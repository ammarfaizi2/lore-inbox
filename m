Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTDXIHp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbTDXIHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:07:45 -0400
Received: from tag.witbe.net ([81.88.96.48]:781 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261809AbTDXIHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:07:41 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Martin Zwickel'" <martin.zwickel@technotrend.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [QUESTION] hdparm -d1 on boot gives strange errors
Date: Thu, 24 Apr 2003 10:19:47 +0200
Message-ID: <024401c30a3a$45221bb0$3f00a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
In-Reply-To: <20030424101212.4687780c.martin.zwickel@technotrend.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> I'm running Gentoo, and on boot, a script enables DMA on all 
> IDE-Devices. For my 1st disk on hdparm -d1 it waits 15secs 
> and kernel gives strange errors. But for my 2nd disk it works ok.

Woah, exactly the same I have, doing the same operation :-)
I have to add that this is happening with a kernel where DMA is
activated by default on IDE disk, so there should be no need to
do that (I didn't try without DMA activated by default).

> Any clues?
> Is it the damn SiS chipset?
Don't know, but got SiS too (Mobo is ASUS P4S8X).

Regards,
Paul

