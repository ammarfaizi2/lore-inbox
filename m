Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVBXXJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVBXXJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 18:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVBXXJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 18:09:01 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:3909 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262527AbVBXXIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 18:08:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ns9p1WdkMJVpclDRpUMrmsDS9weuEBEwgc+U+IF3F89v8RgbsdqsYqP8uORpmaBkGv2d/f/qEeD08zYhB43cSwzs5kSnQGTlqNtqZKYndWQDOB92C/1lHrm3pTZ4rRqIhzPBzQeA4kq3c6F35+YoFEPdc8OKBQnANPCv/AANb+Y=
Message-ID: <a728f9f905022415084f82f769@mail.gmail.com>
Date: Thu, 24 Feb 2005 18:08:50 -0500
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Marvell 88W8310 and 88E8050 PCI Express support
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <20050224143509.4fe2a6a8@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <a728f9f905022413465b96acd4@mail.gmail.com>
	 <20050224143509.4fe2a6a8@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2005 14:35:09 -0800, Stephen Hemminger
<shemminger@osdl.org> wrote:
> On Thu, 24 Feb 2005 16:46:34 -0500
> Alex Deucher <alexdeucher@gmail.com> wrote:
> 
> > I've noticed most of the new AMD64 chipsets now include integrated
> > marvell GigE and wifi chips onboard.  I haven't been able to find much
> > on the status of linux support for these chips.  Apparently the PCIE
> > GigE chip only works with sk98lin
> 
> You need to use the version from SysKonnect.  If you look at the source
> for that, you will see why I started on the skge driver.
> 
> 
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/0010.html
> > Does anyone know if support for the chip is being added to skge?
> 
> As soon as I get the hardware (on order), or a donation of a new system.
> Then I will report the interface from sk98lin.
> 
> > The
> > 88W8310 doesn't seem to be supported at all, at least not that I can
> > see.  Does anyone know the status of the 88W8310?  Are there any
> > experimental drivers?  Is Marvell friendly to opensource?  Are the
> > databooks available?
> 
> If you find databook for Yukon 2 chipset let me know.  I found the original
> Yukon and Genesis manuals, but nothing newer.
> 

Thanks for the info.  If I get a board with a yukon 2, I'd be happy to
help.  I don't suppose you know anything about the wifi chip
(88W8310)?  Jeff?

Thanks,

Alex
