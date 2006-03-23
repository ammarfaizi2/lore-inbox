Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWCWWHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWCWWHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWCWWHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:07:12 -0500
Received: from pproxy.gmail.com ([64.233.166.179]:52001 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932462AbWCWWHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:07:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FGpweZ9Oz4VeTXE+C21R9Qpc17WG0N2bq8VsolQ+nZ4VS8A/KmOBjxdnsXrym4AHX2kWHsAoWA/i3tOvfKTy5uN71qOQI0/23os1KrbyOYpuvQGjnuJg/hz6GL86k2NKg3Ntlg1zH/1LOSMkg0jlrdL45z0GfZka3xVV41L8fpY=
Message-ID: <44229D48.6040502@gmail.com>
Date: Thu, 23 Mar 2006 21:06:16 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sylvain.meyer@worldonline.fr, akpm@osdl.org
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for
 intelfb
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>	 <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com> <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
In-Reply-To: <21d7e9970603222209r45beeb99nccc6435b99b79154@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

> laptop users with these chipsets, getting DVI working is a bit more
> work as there are external chips that need to be driven over i2c, so
> I'll need to at least add i2c support to the i8xx driver. (I noticed
> Sylvain has done some of this work before)..... I'd like to expose i2c
> buses to userspace anyways....

Someone mentioned (I think it was Nicholas Boichat) that the i2c code
of i810fb works for intelfb too, but I cannot verify that.

Tony
