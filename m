Return-Path: <linux-kernel-owner+w=401wt.eu-S1161202AbXAHKYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbXAHKYf (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 05:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161204AbXAHKYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 05:24:35 -0500
Received: from mx.laposte.net ([81.255.54.11]:9770 "EHLO mx.laposte.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161202AbXAHKYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 05:24:35 -0500
Message-ID: <6575.192.54.193.51.1168251859.squirrel@rousalka.dyndns.org>
Date: Mon, 8 Jan 2007 11:24:19 +0100 (CET)
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: "Willy Tarreau" <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.8-2.fc6
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> How would you do this technically in a way that it's significantely
>> easier than simply finishing the UTF=8 transition?

> In how many decades do you think the transition will be finished ?

Right now it looks like it will be finished way earlier than app bother
supporting the later 8-bit encodings such as iso-8859-15

(case in point: Russel's system. I was ROTFL when he proudly announced he
was running a full iso-8859-1 system after dissing UTF-8. Last I've seen
the official 8bit EU encoding was iso-8859-15, and UK is part of the EU)

-- 
Nicolas Mailhot

