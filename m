Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUFAJWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUFAJWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbUFAJWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:22:45 -0400
Received: from host125-180.pool8174.interbusiness.it ([81.74.180.125]:28802
	"EHLO apollo.survival") by vger.kernel.org with ESMTP
	id S264957AbUFAJWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:22:44 -0400
Message-ID: <20040601091957.19180.qmail@apollo.survival>
From: "Marco Marabelli" <mm@smrt.it>
To: linux-kernel@vger.kernel.org
Subject: probls upgrading ram on a 2.4 linuxbox
Date: Tue, 01 Jun 2004 11:19:57 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!
As subject I upgraded my box from 1GB ram to 2GB ram; bios sees all
new memory but kernel doesn'load (error in memory stack).
I have the kernel set with CONFIG_HIGHMEM4G.
I googled everywhere but didn't find any similar problem.
Anyone has a suggestion?
linux 2.4.18 (slackware) on 2x1.6 athlon processor, ram266Mhz no ECC. 

Regards,
Marco Marabelli
