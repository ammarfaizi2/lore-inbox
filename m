Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUIHP6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUIHP6h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUIHP54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:57:56 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:19366 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S268693AbUIHP5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:57:44 -0400
Date: Wed, 8 Sep 2004 18:57:42 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Jens Axboe <axboe@suse.de>
Cc: TazForEver@dlfp.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1
Message-ID: <20040908155742.GA19335@elektroni.ee.tut.fi>
Mail-Followup-To: Jens Axboe <axboe@suse.de>, TazForEver@dlfp.org,
	LKML <linux-kernel@vger.kernel.org>
References: <1094655493.18454.23.camel@athlon> <20040908153439.GM2258@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908153439.GM2258@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 05:34:39PM +0200, Jens Axboe wrote:
> On Wed, Sep 08 2004, Benoit Dejean wrote:
> > is it normal that 2.6.9-rc1 still leaks like hell when burning an audio
> > CD ? i though this was fixed since 2.6.8.1
> 
> hmm no, it should not be. more details, please.

bio_uncopy_user-mem-leak-fix.patch and bio_uncopy_user-mem-leak.patch were
not included in 2.6.9-rc1.
