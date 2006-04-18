Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWDRLwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWDRLwj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWDRLwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:52:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:65439 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932212AbWDRLwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:52:38 -0400
Date: Tue, 18 Apr 2006 12:52:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Lee Revell <rlrevell@joe-job.com>,
       Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       Paul Mundt <lethal@linux-sh.org>,
       Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [linuxsh-dev] [PATCH] ALSA driver for Yamaa AICA on Sega Dreamcast
Message-ID: <20060418115224.GA8591@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>,
	Adrian McMenamin <adrian@mcmen.demon.co.uk>,
	Paul Mundt <lethal@linux-sh.org>,
	Alsa-devel <alsa-devel@lists.sourceforge.net>,
	linux-sh <linuxsh-dev@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1145232784.12804.2.camel@localhost.localdomain> <20060417012913.GA16821@linux-sh.org> <1145304037.9244.27.camel@localhost.localdomain> <1145310435.16138.83.camel@mindpipe> <20060417220512.GA16119@infradead.org> <s5hhd4r9ohh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hhd4r9ohh.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2006 at 12:17:46PM +0200, Takashi Iwai wrote:
> Heh, the suggested line is what CondingStyle suggets -- the output of
> indent program.  Yeah, but better to fix "bad programming" :)

indent only fixes indentation.  Moving the if check to a different line
as the function call changes more than indentation so indent doesn't do it.
Yes, there's more to code codingstyle than just running indent :)

