Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286958AbSABLuF>; Wed, 2 Jan 2002 06:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286962AbSABLtz>; Wed, 2 Jan 2002 06:49:55 -0500
Received: from dsl-213-023-043-195.arcor-ip.net ([213.23.43.195]:42255 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286958AbSABLtm>;
	Wed, 2 Jan 2002 06:49:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Natasha Portillo" <iosglpgc@teleline.es>, <linux-kernel@vger.kernel.org>
Subject: Re: New filesystem and VFS info
Date: Wed, 2 Jan 2002 12:53:35 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000e01c1931f$ec098280$f93a49d4@zeus>
In-Reply-To: <000e01c1931f$ec098280$f93a49d4@zeus>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ljxg-00010h-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 2, 2002 12:56 am, Natasha Portillo wrote:
> Hi!
> 
> I'm making a new filesystem (http://efat.sourceforge.net -> despite the
> name it has nothing to do with Microsoft FAT variants)

Then why call it that?

> and I want to
> know where can I find info about what is supposed to have in a Linux
> Filesystem Driver... (what entry points, what must they do, what kernel
> I/O facilities are available, these info that comes about OS/2 in the
> IFS document and about WinNT in the Microsoft IFSKit)

If that's what you need your best bet is to write it for 2.2 and get a copy 
of 'Understanding the Linux Kernel'.  Otherwise, wait for the 2.4 edition of 
UTLK, otherwise - get ready to do some digging.

--
Daniel
