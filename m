Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUIUVNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUIUVNa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 17:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUIUVN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 17:13:29 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:47580 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268001AbUIUVNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 17:13:21 -0400
Subject: Re: ICH5 SATA problem loading ide-cd module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alon Altman <alon@8ln.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0409212317570.2932@alon1.dhs.org>
References: <Pine.LNX.4.61.0409212317570.2932@alon1.dhs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095797341.31593.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 21:09:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-21 at 21:23, Alon Altman wrote:
> Please Cc me to any replies, as I'm not subscribed to LKML.

Firstly try booting with "acpi=off"

