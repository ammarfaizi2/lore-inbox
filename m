Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVEILbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVEILbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 07:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVEILbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 07:31:49 -0400
Received: from alog0153.analogic.com ([208.224.220.168]:4579 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261250AbVEILbo
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:31:44 -0400
Date: Mon, 9 May 2005 07:31:08 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "aguel.raouf" <aguel.raouf@laposte.net>
cc: Linux-Kernel <Linux-Kernel@vger.kernel.org>
Subject: Re: Raouf From Tunisia
In-Reply-To: <IG7S3H$ECDE8351FD5BB869516C40901B57C29E@laposte.net>
Message-ID: <Pine.LNX.4.61.0505090729440.27328@chaos.analogic.com>
References: <IG7S3H$ECDE8351FD5BB869516C40901B57C29E@laposte.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-512160917-1115638268=:27328"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-512160917-1115638268=:27328
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 May 2005, aguel.raouf wrote:

>
> Hi
>
>
> I must modify my distro to not test the status of root
> directory  (whether it is (is not) writable). For example,
> Slackware is testing the status of the root partition during
> boot and if it's read-write,it will display a message and will
> wait for user input. This is something we don't like, right?
> Unionfs can't be remounted ro, to skip the test. i will need
> to do something for my distro.
> I want to know what i can do, how i can patch my distro
>
> thanks have a good day
>
> Acc=E9dez au courrier =E9lectronique de La Poste : www.laposte.net ;
> 3615 LAPOSTENET (0,34EUR/mn) ; t=E9l : 08 92 68 13 50 (0,34EUR/mn)
>

Not a kernel question. File /etc/rc.sysinit is the init script
that is executed during startup.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-512160917-1115638268=:27328--
