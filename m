Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbRGBN2n>; Mon, 2 Jul 2001 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265100AbRGBN2d>; Mon, 2 Jul 2001 09:28:33 -0400
Received: from smtp1.fw.nextra.de ([212.169.185.140]:45741 "EHLO fw.nextra.de")
	by vger.kernel.org with ESMTP id <S265085AbRGBN2W> convert rfc822-to-8bit;
	Mon, 2 Jul 2001 09:28:22 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: AW: VM Requirement Document - v0.0
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Mon, 2 Jul 2001 15:27:55 +0100
Message-ID: <10AA1A316C98214F8C73CB26D96CEAD8435BC7@bn-ex-01.intern.nextra.de>
Thread-Topic: VM Requirement Document - v0.0
Thread-Index: AcD/1W8o/DUJjtM2T7C/53TEvY6X7gDLY4nA
From: "Jens Hoffmann" <J.Hoffmann@nextra.de>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> My laptop has 256mb of ram, 
> but every day 
> it runs the updatedb for locate. 

The remedy here is simple: Do not run updatedb from cron,
but only when you made changes.

Greetings,
   Jens
