Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWAPAV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWAPAV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 19:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWAPAV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 19:21:27 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:63165 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932135AbWAPAV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 19:21:26 -0500
Date: Mon, 16 Jan 2006 00:21:07 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
Message-ID: <20060116002107.GA4648@srcf.ucam.org>
References: <0ISL001SM95JWW@a34-mta01.direcway.com> <E1EuRN6-0006Hu-00@chiark.greenend.org.uk> <Pine.LNX.4.61.0601152149060.4240@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601152149060.4240@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2006 at 09:49:47PM +0100, Jan Engelhardt wrote:

> I certainly need this patch though, because it allows me to set the LCD 
> brightness via /proc/acpi/sony/brightness.

No, that's sony_acpi. They're different drivers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
