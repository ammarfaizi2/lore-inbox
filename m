Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSIPOKC>; Mon, 16 Sep 2002 10:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbSIPOKC>; Mon, 16 Sep 2002 10:10:02 -0400
Received: from AMontpellier-205-1-13-198.abo.wanadoo.fr ([80.14.68.198]:12167
	"EHLO awak") by vger.kernel.org with ESMTP id <S261806AbSIPOKB> convert rfc822-to-8bit;
	Mon, 16 Sep 2002 10:10:01 -0400
Subject: Re: Hi is this critical??
From: Xavier Bestel <xavier.bestel@free.fr>
To: Mark Veltzer <mark@veltzer.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200209161416.g8GEGNH02280@www.veltzer.org>
References: <Pine.LNX.4.43.0209161537200.5180-100000@cibs9.sns.it>
	<1032184041.7199.14.camel@bip>  <200209161416.g8GEGNH02280@www.veltzer.org>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 16:14:54 +0200
Message-Id: <1032185694.7129.21.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 16/09/2002 à 16:16, Mark Veltzer a écrit :

> 2. The user who posted the question is under no circumstances a "looser" 
> (mind the oo instead of the u...). His question is very valid and the fact 
> that he read dmesg puts him way past any standard computer user.

Well, actually I didn't want to depict *him* as a looser. I was talking
about me :) I've already been confronted with message from the IDE
drivers (and that's when I see them. I'm not always at the console or
reading syslog) and I never remember if they are critical or harmless. I
have to either dig through lkml archives to find what they mean, or ask
lkml what do they mean (to the luser I am).

IDE error/status message aren't visible enough. I'd like to know when my
drive is near failing, without looking at syslog.

	Xav - luser

