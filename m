Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264178AbTHWVkG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 17:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264156AbTHWVkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 17:40:06 -0400
Received: from smtp3.Stanford.EDU ([171.64.14.172]:33465 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S264140AbTHWVkC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 17:40:02 -0400
Date: Sat, 23 Aug 2003 14:39:55 -0700 (PDT)
From: "Benjamin C. Ling" <bling@CS.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Subject: how to inject memory bitflips for maximum damage?
Message-ID: <Pine.LNX.4.44.0308231439040.19230-100000@Xenon.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm hoping there's someone here who has some knowledge on linux's
placement of objects in memory, or can point me to the right direction.

We have FAUmachine (a linux-based fault-injection VM) installed and
running on our research cluster, and can inject memory-bitflips in our
processes running on top of FAUmachine.

My question is -- how do I find out where to inject the bitflip for
maximum damage (or even any damage at all).  I've done a bit of searching
on google but haven't come up with much.

If anyone has any insight on where linux holds its critical memory
structures, or where it places its running programs in physical memory,
could you please let me know?  

Thanks in advance!

Ben


