Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315457AbSIHXDI>; Sun, 8 Sep 2002 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSIHXDI>; Sun, 8 Sep 2002 19:03:08 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:12239
	"EHLO awak") by vger.kernel.org with ESMTP id <S315457AbSIHXDH> convert rfc822-to-8bit;
	Sun, 8 Sep 2002 19:03:07 -0400
Subject: Re: 2.4.19: nosmp=1 => hde: lost interrupt
From: Xavier Bestel <xavier.bestel@free.fr>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0209081831200.27671-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.33.0209081831200.27671-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 01:07:46 +0200
Message-Id: <1031526467.714.0.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 09/09/2002 à 00:31, Mark Hahn a écrit :
> > nosmp=1 noacpi=1 doesn't help.
> 
> "noapic" is the interesting test.
> 

Yep.. works much better then

