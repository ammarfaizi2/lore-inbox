Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263605AbTJ0WIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTJ0WIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:08:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:6059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263605AbTJ0WIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:08:47 -0500
Date: Mon, 27 Oct 2003 14:17:17 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: David Ford <david+powerix@blue-labs.org>
cc: John Mock <kd6pag@qsl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test9 suspend problems
In-Reply-To: <3F9D9483.6080901@blue-labs.org>
Message-ID: <Pine.LNX.4.44.0310271411200.13116-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> AlSA, i8x0

The driver appears to have suspend/resume support, though it's not saving 
PCI config space, and I can't tell where the device is actually put into a 
low-power state. Perhaps the maintainer could provide some insight..

Sorry..


	Pat


