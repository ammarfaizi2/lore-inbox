Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265937AbUAMXpy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 18:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUAMXpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 18:45:54 -0500
Received: from ns1.levanger.kommune.no ([62.148.55.130]:4878 "EHLO
	ns1.levanger.kommune.no") by vger.kernel.org with ESMTP
	id S265937AbUAMXpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 18:45:53 -0500
Message-ID: <1074037303.400482371c489@webmail.levangernett.no>
Date: Wed, 14 Jan 2004 00:41:43 +0100
From: martin@linuxnerds.net
To: linux-kernel@vger.kernel.org
Subject: Ide controller driver migration from 2.4 to 2.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1 / FreeBSD-4.8
X-Originating-IP: 129.241.130.253
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just bought a highpoint rocketraid 1540 card, which has some open source 
drivers. These are ment for 2.4, so when compiled under 2.6, they fail. The 
first error seems to be something about the irq-system (irq.h).

I would like to update the drivers to work under 2.6 aswell, and am wondering 
if this would be an enourmous task, or if it should be possible for some with 
no kernel programming experience.

Has anyone experienced the same, or know what kind of information I am looking 
for? The same problem arose when I compiled the open source driver a promise 
controller.

Thanks, Martin Tingstad.


