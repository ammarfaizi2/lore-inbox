Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281124AbRKKWUN>; Sun, 11 Nov 2001 17:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281125AbRKKWUD>; Sun, 11 Nov 2001 17:20:03 -0500
Received: from AMontpellier-201-1-5-6.abo.wanadoo.fr ([193.251.15.6]:4883 "EHLO
	awak") by vger.kernel.org with ESMTP id <S281124AbRKKWTs> convert rfc822-to-8bit;
	Sun, 11 Nov 2001 17:19:48 -0500
Subject: Re: Best kernel config for exactly 1GB ram
From: Xavier Bestel <xavier.bestel@free.fr>
To: Steve Bergman <steve@uhura.rueb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, steve@rueb.com
In-Reply-To: <3BEEE61A.6050002@uhura.rueb.com>
In-Reply-To: <3BEEE61A.6050002@uhura.rueb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.49 (Preview Release)
Date: 11 Nov 2001 23:13:22 +0100
Message-Id: <1005516803.16817.40.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le dim 11-11-2001 à 21:56, Steve Bergman a écrit :
> Hi,
> 
> 
> I have just upgraded my athlon 1200 system to 1GB ram.  I am unclear as 
> to how I should configure the kernel for this box.  The config.help says 
>    to say no to "high memory support" if the kernel will not run on a 
> machne with more than 1GB.  When I do this I notice that my available 

Actually it's a bit less than 1GB, so you'd better go for 4GB support.

	Xav

