Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136135AbRD0R0l>; Fri, 27 Apr 2001 13:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136132AbRD0R0b>; Fri, 27 Apr 2001 13:26:31 -0400
Received: from AMontpellier-201-1-2-100.abo.wanadoo.fr ([193.253.215.100]:61428
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S136131AbRD0R0Z>; Fri, 27 Apr 2001 13:26:25 -0400
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Padraig Brady <padraig@antefacto.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AE9B203.88B6C799@antefacto.com>
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com> 
	<Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se>
	<15296.988386995@redhat.com>  <3AE9B203.88B6C799@antefacto.com>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/0.10 (Preview Release)
Date: 27 Apr 2001 19:23:41 +0200
Message-Id: <988392226.4700.0.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27 Apr 2001 18:53:07 +0100, Padraig Brady a écrit :

> How much more efficent is JFFS than say ext3+e3compr, wrt:
> logic size/logic speed/RAM requirements/filesystem structure size.

JFFS doesn't have to use the FTL layer between its block device and the
flash - that's a lot already !

Xav

