Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313563AbSIDSOr>; Wed, 4 Sep 2002 14:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSIDSOr>; Wed, 4 Sep 2002 14:14:47 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:59150 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313563AbSIDSOo>;
	Wed, 4 Sep 2002 14:14:44 -0400
Date: Wed, 4 Sep 2002 11:17:23 -0700
From: Greg KH <greg@kroah.com>
To: Jeroen Vreeken <pe1rxq@amsat.org>
Cc: Luca Barbieri <ldb@ldb.ods.org>, petkan@users.sourceforge.net,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020904181723.GB7177@kroah.com>
References: <1030232838.1451.99.camel@ldb> <20020826162204.GB17819@kroah.com> <20020903173347.C377@jeroen.pe1rxq.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020903173347.C377@jeroen.pe1rxq.ampr.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2002 at 05:33:47PM +0200, Jeroen Vreeken wrote:
> On 2002.08.26 18:22:05 +0200 Greg KH wrote:
> > On Sun, Aug 25, 2002 at 01:47:18AM +0200, Luca Barbieri wrote:
> > > ./drivers/usb/media/se401.h
> > 
> > Should be fixed, Jeroen, do you want to do this?
> 
> Attached is a patch against 2.4.20-pre5 that updates the se401 driver to
> update it to version 0.24.
> This fixes the inline problem, a memory leak on disconnect and disables the
> button for cameras that don't support it.
> 
> I haven't been folowing 2.5 for a while, but I think it will apply without
> problems.

Sorry, but the patch does not apply (even after adjusting the path).  I
get lots of failed hunks.

thanks,

greg k-h
