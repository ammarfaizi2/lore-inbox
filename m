Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287115AbSA0NBx>; Sun, 27 Jan 2002 08:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287134AbSA0NBm>; Sun, 27 Jan 2002 08:01:42 -0500
Received: from [194.73.73.81] ([194.73.73.81]:52167 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S287115AbSA0NBZ>; Sun, 27 Jan 2002 08:01:25 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: "'Mark Zealey'" <mark@zealos.org>, "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: fonts corruption with 3dfx drm module
Date: Sun, 27 Jan 2002 13:00:57 -0000
Message-ID: <000301c1a732$a989fa80$132f23d9@stratus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020127122501.GA23825@itsolve.co.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have a graphical console or text? I believe there are fixes in
2.4.18-preX to decrease the 3dfx banshee/v3 pixel clock or something to
alleviate this issue. That'll be in the 3dfx framebuffer driver.

Or, of course, it could be something entirely different....
____________________
Daniel J Blueman 

> On Sun, Jan 27, 2002 at 12:15:01PM +0000, Diego Calleja wrote:
> > I can see fonts corruption when switching from X to console. I use 
> > last stable kernel, but it's been hapenning from earlier 
> versions. I 
> > use iso-8959-15 fonts in console, with tdfx drm module for 
> X, my video 
> > card is voodoo 3 3000 PCI. I hope this can help.
> 
> Yes, I've been seeing this too, it's happened in 2.2.19, 
> 2.2.20 and 2.4.17 (for me). Voodoo banshee PCI card.. it can 
> be annoying, but another switch usially fixes it...

