Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754855AbWKOCfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855AbWKOCfr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbWKOCfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:35:47 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:34091 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1754855AbWKOCfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:35:46 -0500
Date: Tue, 14 Nov 2006 18:35:54 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Stephen.Clark@seclark.us
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: /proc/acpi/dsdt whom to send it to
Message-Id: <20061114183554.9e20430b.randy.dunlap@oracle.com>
In-Reply-To: <455A785F.2070206@seclark.us>
References: <455A785F.2070206@seclark.us>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 21:15:59 -0500 Stephen Clark wrote:

> Hi List,
> 
> I get this from dmesg - where should I send the output.
> 
> Asus Laptop ACPI Extras version 0.30
>   Error calling BSTS
>   unsupported model Z96F, trying default values
>   send /proc/acpi/dsdt to the developers

linux-acpi@vger.kernel.org

---
~Randy
