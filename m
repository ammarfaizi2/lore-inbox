Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTH0MqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263368AbTH0MqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:46:10 -0400
Received: from 200-63-154-224.speedy.com.ar ([200.63.154.224]:61916 "EHLO
	runa.sytes.net") by vger.kernel.org with ESMTP id S263357AbTH0MqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:46:08 -0400
Message-ID: <56555.127.0.0.1.1061988391.squirrel@webmail.runa.sytes.net>
Date: Wed, 27 Aug 2003 09:46:31 -0300 (ART)
Subject: Can't get DHCP info on 2.6.0 test4
From: lists@runa.sytes.net
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all:
I've just booted test4 and the dhcp client can't get the network info.
Also I got some eth timeout messages.

I've tried booting with "noacpi" (I had similar problems with 2.4.x which
I fixed using 'noacpi') but it didn't worked.

My eth card is a realtek 8139 (onboard).

Thanks in advance

