Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTAETbe>; Sun, 5 Jan 2003 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265092AbTAETbe>; Sun, 5 Jan 2003 14:31:34 -0500
Received: from tag.witbe.net ([81.88.96.48]:56327 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S265085AbTAETbd>;
	Sun, 5 Jan 2003 14:31:33 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Randy.Dunlap'" <rddunlap@osdl.org>
Cc: "'Andrew S. Johnson'" <andy@asjohnson.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54 + ACPI] Slow [Was: Re: [2.5.53] So sloowwwww......]
Date: Sun, 5 Jan 2003 20:40:04 +0100
Message-ID: <013701c2b4f2$3f3e0670$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <Pine.LNX.4.33L2.0301051133340.13312-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> | | acpi= kernel parameters, I tried :
> | |  - acpi=no-idle
> |
> | This one (above) is the correct syntax.
> | Looking at the code, it only takes effect if you are using 
> only 1 CPU.
> 
> Sorry, I was looking at old source code.
> apm=no-idle isn't in 2.5.54.

Too bad...
Does this mean there is no easy way to have ACPI running correctly
on my machine ?
If anyone knows ACPI code, please tell me if you want me to run
some specific code to understand what's going on...

Regards,
Paul

