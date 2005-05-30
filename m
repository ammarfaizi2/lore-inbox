Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbVE3RGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVE3RGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVE3RGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:06:40 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:57511 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261448AbVE3RGi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:06:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MAmw+gpVZwm+wfmCKlg7TmwRswWgW3Jr2m9p/lOnRk5c/XVZw50NXWyB5dfc8HRQquRnDbfNKFPNGdZXFcjviR6NDGSBQ3pfPrn8Di3FUzfR5nGdHsajBbyCptcChkxzZdnjVboeDqesula0rhdKc87uUS+m5FHk1C3l5llb+R4=
Message-ID: <d4dc44d505053010066cdaff3@mail.gmail.com>
Date: Mon, 30 May 2005 19:06:38 +0200
From: Schneelocke <schneelocke@gmail.com>
Reply-To: Schneelocke <schneelocke@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel Version Explanation
Cc: randy_dunlap <rdunlap@xenotime.net>, sean@capitalgenomix.com,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
In-Reply-To: <429A792F.9070806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050529140945.GA4815@cgx-mail.capitalgenomix.com>
	 <20050529112523.17f6e8fa.rdunlap@xenotime.net>
	 <429A792F.9070806@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/05, H. Peter Anvin <hpa@zytor.com> wrote:
> > It looks to me like the word "stable" is overused on the main page
> > at www.kernel.org .  I would also prefer to see all of the 2.6.*
> > kernel versions together, above the 2.4.*, 2.2.*, and 2.0.* lines.
> 
> That's because there isn't an odd-number series right now.

Will there ever be one again (at least in the foreseeable future)?
We've had "Linus = stable, -mm = unstable" for a long time now, and it
seems pretty much official now that there won't be a 2.7 anytime soon.
The actual development of new features is happening in the relevant
maintainers' trees, anyway, so there simply seems to be no need for a
single highly development-oriented tree (like 2.5 was) anymore - quite
the contrary.

>         -hpa

-- 
schnee
