Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTF0Qfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 12:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264490AbTF0Qfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 12:35:51 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:25535 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S264479AbTF0Qfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 12:35:50 -0400
Message-ID: <3EFC7716.8050804@blue-labs.org>
Date: Fri, 27 Jun 2003 12:55:50 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030626
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: laptop w/ external keyboard misprint FYI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.73, first time I've used an external keyboard

When I plug my external Logitech keyboard into my laptop, (shared 
keyboard/mouse port), dmesg output indicates a generic mouse was 
attached instead of a keyboard.  The keyboard works, it's just the dmesg 
info that's inaccurate.

Keyboard plugged in:
input: PS/2 Generic Mouse on isa0060/serio1

Mouse plugged in:
input: PS/2 Logitech Mouse on isa0060/serio1


David


