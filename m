Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbULAQqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbULAQqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbULAQqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:46:12 -0500
Received: from s1.mailresponder.info ([193.24.237.10]:2052 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S261327AbULAQqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:46:10 -0500
Subject: Re: setting up EFI on x86
From: Mathieu Fluhr <mfluhr@nero.com>
To: Daniel Dickman <didickman@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0412011026560.4358@chaos.analogic.com>
References: <41ADD53F.9090307@yahoo.com>
	 <Pine.LNX.4.61.0412011026560.4358@chaos.analogic.com>
Content-Type: text/plain
Organization: Ahead Software AG.
Date: Wed, 01 Dec 2004 17:41:28 +0100
Message-Id: <1101919288.1047.14.camel@c-l-175>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

EFI is basically used for the Intel Itanium processors, and I think if
your MB does not have such an EFI shell a startup, you will not be able
to use EFI.

Regards,
Mathieu

On Wed, 2004-12-01 at 10:29 -0500, linux-os wrote:
> On Wed, 1 Dec 2004, Daniel Dickman wrote:
> 
> > I just got an older x86 desktop system and I wanted to learn about EFI
> > by booting the kernel using this instead of the older MBR-style boot
> > process. Does anyone know how I can set up such a system on x86?
> > Specifically, what tools can I use to create a GPT disk? Do I need a
> > special BIOS to do this?
> >
> > Thanks for any help with this.
> > -
> 
> This is the new  "thing" being pushed by WIN/Intel. I haven't seen
> any motherboards that support it yet. All the new ones that come
> into this place have a BIOS that loads the MBR and starts trucking
> from there.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by John Ashcroft.
>                   98.36% of all statistics are fiction.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

