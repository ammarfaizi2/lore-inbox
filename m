Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSBZXAu>; Tue, 26 Feb 2002 18:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287149AbSBZXAn>; Tue, 26 Feb 2002 18:00:43 -0500
Received: from jalon.able.es ([212.97.163.2]:18399 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S286959AbSBZXAe>;
	Tue, 26 Feb 2002 18:00:34 -0500
Date: Wed, 27 Feb 2002 00:00:24 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Steve Lord <lord@sgi.com>
Cc: Andreas Dilger <adilger@turbolabs.com>,
        "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
Message-ID: <20020227000024.G6197@werewolf.able.es>
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com> <20020226140644.U12832@lynx.adilger.int> <1014760581.5993.159.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1014760581.5993.159.camel@jen.americas.sgi.com>; from lord@sgi.com on mar, feb 26, 2002 at 22:56:21 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020226 Steve Lord wrote:
>On Tue, 2002-02-26 at 15:06, Andreas Dilger wrote:
>> On Feb 26, 2002  12:38 -0800, Dennis, Jim wrote:
>> >  Now I need to know about the status of several unofficial patches:
>> 
>> While my word is by no means official, my general understanding is:
>> 
>> > 	XFS
>> 
>> Not for 2.4 - just too many changes to the core kernel code.
>
>Someone has got to kill this assumption people have about XFS, it
>makes much smaller changes than some things which have gone in,
>the odd VM rewrite here and there to name some. Given that we now
>have official EA system calls, the last chunk of stuff to resolve
>is quota. This is being worked on with Jan Kara.
>

AFAIK, it does not so many changes but duplicates half the fs 
infrastructure already present in kernel just to have a common
codebase with IRIX.

Is this still true ?
Is anybody working in kill all the dups ?
 
-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-jam1 #1 SMP Tue Feb 26 00:06:55 CET 2002 i686
