Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUBYW6K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUBYW6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:58:03 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:45552 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261594AbUBYW50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:57:26 -0500
Cc: Kai Engert <kaie@kuix.de>, linux-kernel@vger.kernel.org
To: Ben Collins <bcollins@debian.org>
Subject: Re: only ieee1394 from 2.4.20 works for me
From: Holger Gruber <holger@gruber-frankfurt.de>
Content-Type: text/plain; format=flowed; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Date: Wed, 25 Feb 2004 23:54:35 +0100
Message-ID: <opr3x689pvs25p2c@localhost>
User-Agent: Opera7.21/Linux M2 build 480
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I have exactly the same problem with my ieee1394 mass storage device.
To solve it, I did the same as Kai and replaced the drivers/ieee1394
directory for kernel versions later than 2.4.20 with those found in
2.4.20.
The problem seems to be the same with 2.6.x kernel series. I didn't
investigate this further, but I think I will be able to send to you
the reports needed the next days.

Holger
PS: Please CC me on replies.
