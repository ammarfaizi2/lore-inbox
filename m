Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUCVIa7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 03:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbUCVIa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 03:30:59 -0500
Received: from mx.laposte.net ([81.255.54.11]:25301 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S261802AbUCVIa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 03:30:58 -0500
Date: Mon, 22 Mar 2004 09:30:09 +0100
Message-Id: <HUYYA9$2597BB7BC2D4D49619A62646AB9559DD@laposte.net>
Subject: Re:[PATCH] tipar char driver (divide by zero)
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From: "sebastien\.bourdeauducq" <sebastien.bourdeauducq@laposte.net>
To: "romain" <romain@lievin.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "greg" <greg@kroah.com>
X-XaM3-API-Version: 4.1 (B15)
X-type: 0
X-SenderIP: 195.221.155.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A patch about the tipar.c char driver has been sent on lkml by Sebastien Bourdeau. It fixes a divide-by-zero error when we try to read/write data after setting the timeout to 0.
My name's actually "Bourdeauducq". By the way can you cc me any replies about this patch as I'm not subscribed to lkml.

Accédez au courrier électronique de La Poste : www.laposte.net ; 
3615 LAPOSTENET (0,34€/mn) ; tél : 08 92 68 13 50 (0,34€/mn)



