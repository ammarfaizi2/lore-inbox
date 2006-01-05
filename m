Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752108AbWAEHzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbWAEHzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbWAEHzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:55:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:22485 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752108AbWAEHzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:55:38 -0500
Date: Thu, 5 Jan 2006 08:55:35 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ben Collins <bcollins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
In-Reply-To: <0ISL001SM95JWW@a34-mta01.direcway.com>
Message-ID: <Pine.LNX.4.61.0601050854240.10161@yvahk01.tjqt.qr>
References: <0ISL001SM95JWW@a34-mta01.direcway.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Date: Wed, 04 Jan 2006 17:00:38 -0500
>From: Ben Collins <bcollins@ubuntu.com>
>To: linux-kernel@vger.kernel.org
>Subject: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
>

Yay, will this make the Fn+F5 (brightness) and Fn+F7 (LCD/VGA switch) etc.
work? Currently, they just give a keycode in the 450-460 area (`showkey`).



Jan Engelhardt
-- 
