Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRLNXRL>; Fri, 14 Dec 2001 18:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280817AbRLNXRB>; Fri, 14 Dec 2001 18:17:01 -0500
Received: from AMontpellier-201-1-5-9.abo.wanadoo.fr ([193.251.15.9]:60937
	"EHLO awak") by vger.kernel.org with ESMTP id <S280365AbRLNXQz> convert rfc822-to-8bit;
	Fri, 14 Dec 2001 18:16:55 -0500
Subject: Re: freeze (2.4.17-pre/rc + Promise 20265)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Francois Romieu <romieu@cogenit.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011215000534.A3993@se1.cogenit.fr>
In-Reply-To: <20011214231932.A2949@se1.cogenit.fr>
	<1008369045.1793.46.camel@nomade>  <20011215000534.A3993@se1.cogenit.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.14.09.00 (Preview Release)
Date: 15 Dec 2001 00:09:54 +0100
Message-Id: <1008371395.2049.52.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le sam 15-12-2001 à 00:05, Francois Romieu a écrit :
> Xavier Bestel <xavier.bestel@free.fr> :
> > Click left mouse button to restart and disable ACPI
> 
> Nothing changed.
> 
> <head scratch>
> What makes you believe there's X on this machine ?

Well, I have the exact same symptom and have seen it reported here by
others, and the cause is ACPI, since several kernel revisions.
But I read your dmesg, apparently you didn't configure it.

	Xav

