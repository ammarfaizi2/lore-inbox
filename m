Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSHYMe6>; Sun, 25 Aug 2002 08:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317347AbSHYMe6>; Sun, 25 Aug 2002 08:34:58 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:56024 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S317341AbSHYMe6>; Sun, 25 Aug 2002 08:34:58 -0400
Date: Sun, 25 Aug 2002 14:38:59 +0200
Message-Id: <200208251238.g7PCcxX03888@mailgate5.cinetic.de>
MIME-Version: 1.0
Organization: http://freemail.web.de/
From: <joerg.beyer@email.de>
To: joerg.beyer@email.de, "ZwaneMwaikambo" <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: big IRQ latencies, was:  <no subject>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> schrieb am 25.08.02 14:10:12:
> On Sun, 25 Aug 2002 joerg.beyer@email.de wrote:
...
> That should fix your slowdown during untarring/disk access, as for your 
> NIC problem looks like you might be having a receive FIFO overflow, so 
> perhaps the card stops processing incoming packets? I have no clue, 

maybe this helps: outgoing transfer (from the laptop to some other
machine) is reasonable fast: I could copy gig's of data away, but not
to the machine. I asume sending away makes not so heavy use
of IRQ's, right?

    does this help?
    Joerg

ps: sorry for the missing subjectline



