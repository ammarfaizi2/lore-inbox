Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSL2SOt>; Sun, 29 Dec 2002 13:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSL2SOt>; Sun, 29 Dec 2002 13:14:49 -0500
Received: from smtp-outbound.cwctv.net ([213.104.18.10]:57118 "EHLO
	smtp.cwctv.net") by vger.kernel.org with ESMTP id <S261302AbSL2SOq>;
	Sun, 29 Dec 2002 13:14:46 -0500
From: <Hell.Surfers@cwctv.net>
To: john@grabjohn.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org
Date: Sun, 29 Dec 2002 18:22:15 +0000
Subject: RE: [2.5.53] So sloowwwww......
MIME-Version: 1.0
X-Mailer: Liberate TVMail 2.6
Content-Type: multipart/mixed;
 boundary="1041186135714"
Message-ID: <024ec1019181dc2DTVMAIL8@smtp.cwctv.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1041186135714
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

could be worse, could be XP...

Regards, Dean.

On 	Sun, 29 Dec 2002 17:54:03 +0000 (GMT) 	John Bradford <john@grabjohn.com> wrote:

--1041186135714
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from vger.kernel.org ([209.116.70.75]) by smtp.cwctv.net  with Microsoft SMTPSVC(5.5.1877.447.44);
	 Sun, 29 Dec 2002 17:54:25 +0000
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSL2RqD>; Sun, 29 Dec 2002 12:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSL2RqD>; Sun, 29 Dec 2002 12:46:03 -0500
Received: from [81.2.122.30] ([81.2.122.30]:45829 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265424AbSL2RqC>;
	Sun, 29 Dec 2002 12:46:02 -0500
Received: from darkstar.example.net (localhost [127.0.0.1])
	by darkstar.example.net (8.12.4/8.12.4) with ESMTP id gBTHs36Q001526;
	Sun, 29 Dec 2002 17:54:03 GMT
Received: (from root@localhost)
	by darkstar.example.net (8.12.4/8.12.4/Submit) id gBTHs3Cd001525;
	Sun, 29 Dec 2002 17:54:03 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200212291754.gBTHs3Cd001525@darkstar.example.net>
Subject: Re: [2.5.53] So sloowwwww......
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sun, 29 Dec 2002 17:54:03 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E0F3545.4040601@colorfullife.com> from "Manfred Spraul" at Dec 29, 2002 06:47:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Return-Path: linux-kernel-owner+Hell.Surfers=40cwctv.net@vger.kernel.org

> I'd guess power management, a runaway interrupt, bad mtrr settings, 
> problems with the memory map decoding or Hyperthreading.
> 
> Check
> /proc/interrupts
> /proc/mtrr
> The memory detection results at the top of dmesg
> disable apm, acpi.
> Check anything Hyperthreading related in dmesg.

Also, toggle the APIC config settings.

John.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--1041186135714--


