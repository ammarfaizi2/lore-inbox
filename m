Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757839AbWKYFzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839AbWKYFzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 00:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757840AbWKYFzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 00:55:00 -0500
Received: from uni21mr.unity.ncsu.edu ([152.1.2.137]:9899 "EHLO
	uni21mr.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S1757839AbWKYFy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 00:54:59 -0500
Subject: Overriding X on panic
From: Casey Dahlin <cjdahlin@ncsu.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 25 Nov 2006 00:54:53 -0500
Message-Id: <1164434093.10503.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 5.2.1.279297, Antispam-Engine: 2.5.0.283055, Antispam-Data: 2006.11.24.211432
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus did say that he would do anything within reason to help desktop
linux forward, and frankly a big step forward would be to get error
messages to the user. What might be some safe options for overriding,
switching away from, killing, or otherwise disposing of the X server
when an unrecoverable Oops is about to occur on the TTY?

-Casey Dahlin
cjdahlin@ncsu.edu

