Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265914AbUBJOpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUBJOpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:45:14 -0500
Received: from smtp02.web.de ([217.72.192.151]:42504 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265914AbUBJOpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:45:12 -0500
Subject: Re: Problems getting dma working with the sc1200.c ide driver
From: Axel Waggershauser <awagger@web.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1076424311.1877.10.camel@strand.wg>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 15:45:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it turned out that the mentioned hardware (X-board) is actually missing
some DMA related wires between the ide-controller and the drive. So this
is never going to work :-(.

Thanks, Axel.

