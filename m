Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281730AbRKULVb>; Wed, 21 Nov 2001 06:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281726AbRKULVW>; Wed, 21 Nov 2001 06:21:22 -0500
Received: from [62.58.73.254] ([62.58.73.254]:22512 "EHLO
	ats-core-0.atos-group.nl") by vger.kernel.org with ESMTP
	id <S281724AbRKULVM>; Wed, 21 Nov 2001 06:21:12 -0500
Date: Wed, 21 Nov 2001 12:14:18 +0100 (CET)
From: Ryan Sweet <rsweet@atos-group.nl>
To: Roberto Fichera <kernel@tekno-soft.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SDK for iPAQ
In-Reply-To: <5.1.0.14.2.20011121114716.034e7a60@mail.tekno-soft.it>
Message-ID: <Pine.LNX.4.30.0111211211080.15627-100000@core-0>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Nov 2001, Roberto Fichera wrote:

> I need to know where can I download a complete native SDK for iPAQ (not a
> cross-compiler).
> I need to get a native development tools because I want recompile
> some applications that perform some gcc tests like configure.

See http://www.handhelds.org.

> This development tools should be mounted from an external share like nfs or
> smbfs
> because there isn't enough space on the iPAQ, right ?

nfs is used typically, though if you only want to compile, and don't have
easy access to an ipaq, you can use the skiff cluster, from compaq; see
handhelds.org (as above) and search for skiff cluster.

> And finally, does anyone know if smbfs works well on iPAQ ?

yes, it does.  You will have to install the samba ipkg.

-- 
Ryan Sweet <ryan.sweet@atosorigin.com>
Atos Origin Engineering Services
http://www.aoes.nl

