Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbULTP7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbULTP7w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbULTP7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:59:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29933 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261545AbULTP7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:59:51 -0500
Subject: Re: [PATCH] it8212.c, kernel 2.6.9-ac16
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Philipp E, Imhof" <fippu@fippu.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41C2E6B6.20701@fippu.ch>
References: <41C2E6B6.20701@fippu.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103554559.29867.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 14:56:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-17 at 14:01, Philipp E, Imhof wrote:
> I do not know whether the 8212 and the 8211 are fully
> compatible, but in my computer, 8211 works fine with 8212's
> driver.

Reading the datasheet I believe they are except that for IT8211 we
should not be checking for smart mode perhaps ?

