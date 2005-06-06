Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVFFVrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVFFVrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 17:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVFFVqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 17:46:35 -0400
Received: from schokokeks.org ([193.201.54.11]:27400 "EHLO a.mx.schokokeks.org")
	by vger.kernel.org with ESMTP id S261703AbVFFVqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 17:46:16 -0400
From: Hanno =?utf-8?q?B=C3=B6ck?= <mail@hboeck.de>
To: randy_dunlap <rdunlap@xenotime.net>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, julien.lerouge@free.fr
Subject: Re: Kernel oops with asus_acpi module
Date: Mon, 6 Jun 2005 23:47:09 +0200
User-Agent: KMail/1.8.1
References: <200506052340.41074.mail@hboeck.de> <20050606135459.7ad699ae.rdunlap@xenotime.net> <20050606213248.GA22238@hell.org.pl>
In-Reply-To: <20050606213248.GA22238@hell.org.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506062347.10582.mail@hboeck.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. Juni 2005 23:32 schrieb Karol Kozimor:
> May I see the DSDT? The Samsung P30 INIT method referenced in
> asus_hotk_get_info() is not supposed to return anything, not even an empty
> string. I believe the new ACPICA implicit return might be interfering.
> Here's the relevant part of what I based the code on:

http://www.schokokeks.org/~hanno/dsdt_p30
