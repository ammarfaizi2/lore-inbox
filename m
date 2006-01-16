Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWAPMA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWAPMA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWAPMA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:00:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:12001 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750717AbWAPMA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:00:57 -0500
Date: Mon, 16 Jan 2006 13:00:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthew Garrett <mjg59@srcf.ucam.org>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
In-Reply-To: <20060116002107.GA4648@srcf.ucam.org>
Message-ID: <Pine.LNX.4.61.0601161300440.7465@yvahk01.tjqt.qr>
References: <0ISL001SM95JWW@a34-mta01.direcway.com> <E1EuRN6-0006Hu-00@chiark.greenend.org.uk>
 <Pine.LNX.4.61.0601152149060.4240@yvahk01.tjqt.qr> <20060116002107.GA4648@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I certainly need this patch though, because it allows me to set the LCD 
>> brightness via /proc/acpi/sony/brightness.
>
>No, that's sony_acpi. They're different drivers.

My bad.


Jan Engelhardt
-- 
