Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbVCSUHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbVCSUHg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVCSUHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 15:07:33 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:54659 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261748AbVCSUHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 15:07:30 -0500
Subject: Re: [2.6 patch] net/bluetooth/rfcomm/core.: make a variable static
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Max Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.net,
       Network Development Mailing List <netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050315143903.GK3189@stusta.de>
References: <20050315143903.GK3189@stusta.de>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 21:06:57 +0100
Message-Id: <1111262817.9203.0.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch makes a needlessly global variable static.

the patch is in my tree now. Thanks.

Regards

Marcel


