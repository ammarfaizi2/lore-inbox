Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316143AbSEOMuH>; Wed, 15 May 2002 08:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316156AbSEOMuH>; Wed, 15 May 2002 08:50:07 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:51335
	"EHLO awak") by vger.kernel.org with ESMTP id <S316143AbSEOMuG> convert rfc822-to-8bit;
	Wed, 15 May 2002 08:50:06 -0400
Subject: Re: [RFC] FAT extension filters
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Malcolm Smith <msmith@operamail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chaffee@cs.berkeley.edu
In-Reply-To: <200205150318.g4F3IPY103245@saturn.cs.uml.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 May 2002 14:49:14 +0200
Message-Id: <1021466960.11330.27.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 15/05/2002 à 05:18, Albert D. Cahalan a écrit :
> Also I found a bug in the vfat code. It doesn't
> properly handle old (pre-vfat) files with names
> that start with 0xE5; these are stored on disk
> with 0x05 as the first character.

Isn't this a deleted file ?

	


