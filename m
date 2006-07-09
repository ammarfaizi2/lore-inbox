Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbWGIWmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbWGIWmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWGIWmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:42:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41125 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161207AbWGIWmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:42:20 -0400
Date: Sun, 9 Jul 2006 15:38:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Brown, Len" <len.brown@intel.com>
cc: Adrian Bunk <bunk@stusta.de>,
       "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de,
       linux-acpi@vger.kernel.org, Miles Lane <miles.lane@gmail.com>
Subject: RE: ACPI_DOCK bug: noone cares
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6ECF9E5@hdsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0607091538470.5623@g5.osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6ECF9E5@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Brown, Len wrote:
> 
> So I ask you.  If I fix the Kconfig issue today, will you accept
> a push that restores this driver to 2.6.18?

Sure.

		Linus
