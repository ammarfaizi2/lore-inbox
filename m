Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSBZX2a>; Tue, 26 Feb 2002 18:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSBZX2K>; Tue, 26 Feb 2002 18:28:10 -0500
Received: from jalon.able.es ([212.97.163.2]:61664 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S288019AbSBZX2H>;
	Tue, 26 Feb 2002 18:28:07 -0500
Date: Wed, 27 Feb 2002 00:27:58 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: wwp <subscript@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: low latency & preemtible kernels
Message-ID: <20020227002758.A6669@werewolf.able.es>
In-Reply-To: <200202261918.53190.Dieter.Nuetzel@hamburg.de> <20020226235510.E6197@werewolf.able.es> <20020227001246.58608e37.subscript@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20020227001246=2E58608e3?=
	=?iso-8859-1?Q?7=2Esubscript=40free=2Efr=3E=3B_from_subscript=40free=2Efr?=
	=?iso-8859-1?Q?_on_mi=E9=2C?= feb 27, 2002 at 00:12:46 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020227 wwp wrote:
>Hi J.A.,
>
>
>On Tue, 26 Feb 2002 23:55:10 +0100 "J.A. Magallon" <jamagallon@able.es> wrote:
>
>[snip]
>> >Try 2.4.18-rc4-jam2 for example. It should apply against 2.4.18 final, too.
>> >
>> 
>> Correction: jam2 is O(1)-multi-queue scheduler + low-latency, no
>> preeemt there.
>
>Won't 2.4.18-jam1 better?
>

Same patches over a more recent kernel.
Even 2.4.18-jam1 includes the fix for the personality problem.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-jam1 #1 SMP Tue Feb 26 00:06:55 CET 2002 i686
