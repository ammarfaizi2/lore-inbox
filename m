Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbSIYMol>; Wed, 25 Sep 2002 08:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261970AbSIYMol>; Wed, 25 Sep 2002 08:44:41 -0400
Received: from hosting1.globalone.net.co ([216.72.142.131]:56565 "EHLO
	Sunny.noldata.com") by vger.kernel.org with ESMTP
	id <S261968AbSIYMol>; Wed, 25 Sep 2002 08:44:41 -0400
From: glozano@noldata.com
Date: Wed, 25 Sep 2002 07:50:33 -0400 (EDT)
To: linux-kernel@vger.kernel.org
Subject: eepro100 problem
Message-ID: <Pine.GSO.4.10.10209250748230.19677-100000@Sunny.noldata.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I just upgraded one of our firewalls to 2.4.19.

After working for 15 minutes the eth0 turned dead (the MZ running there),
showing the next message in the kernel:

Sep 25 07:51:37 machine_gun kernel: eepro100: wait_for_cmd_done timeout!
Sep 25 07:51:39 machine_gun last message repeated 2 times

The log is now full with the same message, I cant understand the
eepro100.c code enough to find the problem.

Regards.

Gustavo

___
Gustavo A. Lozano

I know not with what weapons World War III will be fought,
but World War IV will be fought with sticks and stones. 
					Albert Einstein

