Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSBZWzu>; Tue, 26 Feb 2002 17:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSBZWzl>; Tue, 26 Feb 2002 17:55:41 -0500
Received: from jalon.able.es ([212.97.163.2]:56542 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S285720AbSBZWzW>;
	Tue, 26 Feb 2002 17:55:22 -0500
Date: Tue, 26 Feb 2002 23:55:10 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Dieter =?iso-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: wwp <subscript@free.fr>, Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: low latency & preemtible kernels
Message-ID: <20020226235510.E6197@werewolf.able.es>
In-Reply-To: <200202261918.53190.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
In-Reply-To: <200202261918.53190.Dieter.Nuetzel@hamburg.de>; from Dieter.Nuetzel@hamburg.de on mar, feb 26, 2002 at 19:18:52 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020226 Dieter Nützel wrote:
>wwp wrote:
>> Hi there,
>>
>> here's a newbie question:
>> is it UNadvisable to apply both preempt-kernel-rml and low-latency patches
>> over a 2.4.18 kernel?
>
>In short: no ;-)
>
>Try 2.4.18-rc4-jam2 for example. It should apply against 2.4.18 final, too.
>

Correction: jam2 is O(1)-multi-queue scheduler + low-latency, no
preeemt there.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-jam1 #1 SMP Tue Feb 26 00:06:55 CET 2002 i686
