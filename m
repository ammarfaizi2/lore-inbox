Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbUKFU4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUKFU4j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUKFU4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:56:39 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:43752 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261468AbUKFU4h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:56:37 -0500
Subject: Re: [2.6 patch] drivers/bluetooth/: make some functions static
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, linux-net@vger.kernel.org
In-Reply-To: <20041106201630.GN1295@stusta.de>
References: <20041106201630.GN1295@stusta.de>
Content-Type: text/plain
Date: Sat, 06 Nov 2004 21:55:52 +0100
Message-Id: <1099774552.6919.91.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> The patch below makes some needlessly global functions under 
> drivers/bluetooth/ static.

applied. Thanks.

Regards

Marcel


