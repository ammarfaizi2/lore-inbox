Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265575AbSJSJiH>; Sat, 19 Oct 2002 05:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265577AbSJSJiH>; Sat, 19 Oct 2002 05:38:07 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:39120 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S265575AbSJSJiG> convert rfc822-to-8bit; Sat, 19 Oct 2002 05:38:06 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: Gerrit =?iso-8859-1?q?Bruchh=E4user?= <gbruchhaeuser@orga.com>
Subject: Re: bootsect.S and magic address 0x78
Date: Fri, 18 Oct 2002 23:44:05 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <3DAFDC88.2010009@orga.com>
In-Reply-To: <3DAFDC88.2010009@orga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210182344.05223.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 October 2002 05:03, Gerrit Bruchhäuser wrote:
> Hello Linus,
>
>
> Can you tell me where this magic address 0x78 in arch/i386/bootsect.S
> refers to? I mean, is this somewhere specified?
>
> Many thanks and cheers from germany.
>
> Gerrit

I believe Tigran's Linux Kernel Internels guide for 2.4 covers this, you can 
download it from here:

http://www.tldp.org/guides.html

Alas, there isn't a 2.5 guide yet.  Moves too fast. :)

Rob
