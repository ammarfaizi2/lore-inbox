Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSGMP5V>; Sat, 13 Jul 2002 11:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSGMP5U>; Sat, 13 Jul 2002 11:57:20 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:61348 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S315167AbSGMP5T>; Sat, 13 Jul 2002 11:57:19 -0400
Message-Id: <200207131559.g6DFx6E07743@colombe.home.perso>
Date: Sat, 13 Jul 2002 17:59:03 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: Linux 2.4.19-rc1-ac3
To: alan@redhat.com
Cc: linux-kernel@vger.kernel.org, swsusp@lister.fornax.hu
In-Reply-To: <200207121914.g6CJEcN32497@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12 Jul, Alan Cox a écrit :
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> This is mostly a housekeeping patch designed to shrink diff sizes down
> and get ready for 2.4.20pre merging. Promise users please test this with
> *caution*. It should fix large drives on the 20262/3 but change nothing
> else but namings.
> 
> Linux 2.4.19rc1-ac3
> o	Remove SWSUSPEND
> 	| With the IDE backport option and other general 2.5 improvements
> 	| its now best worked on in 2.5

Thanks, that'll make me have less to do to maintain 2.4 swsusp patch.

--
Florent Chabaud 

