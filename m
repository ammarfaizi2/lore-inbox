Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTI3Km0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTI3Km0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:42:26 -0400
Received: from inmail.compaq.com ([161.114.1.205]:44804 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261298AbTI3KmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:42:25 -0400
Message-ID: <3F795EC5.D4B6C813@Phreaker.net>
Date: Tue, 30 Sep 2003 16:15:25 +0530
From: Raj <obelix@Phreaker.net>
X-Mailer: Mozilla 4.75 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ERR in /proc/interrupts
References: <slrnbnijq7.41m.usenet.2117@home.andreas-s.net> <3F795816.7050805@g-house.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ERR is incremented in the case of errors in the IO-APIC bus (the bus

I have observed that ERR is incremented in case of spurious interrupts
too.

/Raj
