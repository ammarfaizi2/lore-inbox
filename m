Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbTJNSEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbTJNSEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:04:05 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:50832 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262676AbTJNSEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:04:02 -0400
Message-ID: <3F8C3A99.6020106@opensound.com>
Date: Tue, 14 Oct 2003 11:04:09 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mouse driver bug in 2.6.0-test7?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why is the PS2 mouse tracking about 2x faster in 2.6.0-test7 compared
to 2.4.xx?. Has anybody else seen this problem?.

If I move the mouse 1 inch horizontally left-to-right on the mouse
pad, the cursor on the screen moves almost twice the distance on the
screen compared to Linux 2.4.xx

I'm using the same X11 Config in 2.6 and 2.4....


Best regards
Dev Mazumdar
-----------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA.
Tel: (310) 202 8530		URL: www.opensound.com
Fax: (310) 202 0496 		Email: info@opensound.com
-----------------------------------------------------------



