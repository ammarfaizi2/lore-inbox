Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287516AbSAPT6q>; Wed, 16 Jan 2002 14:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287432AbSAPT6g>; Wed, 16 Jan 2002 14:58:36 -0500
Received: from ns.censoft.com ([208.219.23.2]:63896 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S287450AbSAPT6c>;
	Wed, 16 Jan 2002 14:58:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jordan Crouse <jordanc@censoft.com>
Reply-To: jordanc@censoft.com
Organization: The Microwindows Project
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Query about initramfs and modules
Date: Wed, 16 Jan 2002 12:53:49 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <15428.47094.435181.278715@irving.iisd.sra.com> <20020116202958.E18039@devcon.net> <20020116194026.GD1964@kroah.com>
In-Reply-To: <20020116194026.GD1964@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QwCa-0007Od-00@ns.censoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree.  It's a lot of drivers (and it's growing.)  It will help out
> people booting from a hard disk the most (which happen to be the
> majority of people :)

And yet, I see the greatest potential for initramfs coming from devices  that 
*don't* boot from a hard drive.  I know tons of embedded devices that have 
very evil looking init scripts just to boot something other than a hard 
drive.  Man, if the initramfs could handle all those cases uniformly, it 
would be a huge advantage for the embedded world.

Jordan
