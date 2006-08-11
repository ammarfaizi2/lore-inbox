Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWHKTtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWHKTtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 15:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWHKTtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 15:49:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:61337 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932369AbWHKTtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 15:49:42 -0400
Subject: Re: [PATCH] Image capturing driver for Basler eXcite smart camera
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Koeller <thomas.koeller@baslerweb.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <200608102318.04512.thomas.koeller@baslerweb.com>
References: <200608102318.04512.thomas.koeller@baslerweb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Aug 2006 21:09:43 +0100
Message-Id: <1155326983.24077.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-10 am 23:18 +0200, ysgrifennodd Thomas Koeller:
> This is a driver used for image capturing by the Basler eXcite smart camera
> platform.

drivers/media/video and the Video4Linux2 API deal with image capture in
Linux. It provides a common API for video and thus image capture. Any
reason that interface is not suitable.

Alan
