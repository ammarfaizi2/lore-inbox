Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319127AbSIJOCm>; Tue, 10 Sep 2002 10:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319128AbSIJOCk>; Tue, 10 Sep 2002 10:02:40 -0400
Received: from ns.suse.de ([213.95.15.193]:18950 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319127AbSIJOCO>;
	Tue, 10 Sep 2002 10:02:14 -0400
Date: Tue, 10 Sep 2002 16:07:00 +0200
From: Dave Jones <davej@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-ID: <20020910160659.A15158@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Hans Reiser <reiser@namesys.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org, green@namesys.com
References: <3D7DF05E.7030903@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D7DF05E.7030903@namesys.com>; from reiser@namesys.com on Tue, Sep 10, 2002 at 05:15:10PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 05:15:10PM +0400, Hans Reiser wrote:

 > It passes all of our testing, but it is the kind of code that is more 
 > likely than most to have elusive lurking bugs.  It cannot be tested in 
 > 2.5 first because 2.5 is too broken at this particular moment.

What in particular holds you back from testing this in 2.5 ?
This seems quite dubious for inclusion first in what it supposed
to be the stable series.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
