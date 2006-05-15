Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWEOJmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWEOJmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWEOJmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:42:45 -0400
Received: from mail-a02.ithnet.com ([217.64.83.97]:60571 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S932348AbWEOJmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:42:45 -0400
X-Sender-Authentication: net64
Date: Mon, 15 May 2006 11:42:43 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: mcelog ?
Message-Id: <20060515114243.8ccaa9aa.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can some kind soul please shortly explain what this message tells me:

HARDWARE ERROR
CPU 1: Machine Check Exception:                4 Bank 4: b60a200170080813
TSC 89cfb4725b17 ADDR 1025cb3f0 
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Machine check



Of course I ran mcelog but I don't quite understand how the additional info
helps me finding the problem.
Is this a problem with RAM? And if, which one?

The box is a dual opteron with two banks of mem (4 sockets each), each socket
holding a 1 GB mem module.

Thanks for any hints.
-- 
Regards,
Stephan

