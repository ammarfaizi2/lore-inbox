Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262022AbUL1CoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUL1CoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 21:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbUL1CoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 21:44:17 -0500
Received: from fmr13.intel.com ([192.55.52.67]:48270 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S262022AbUL1CoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 21:44:14 -0500
Subject: Re: Problems with 2.6.10
From: Len Brown <len.brown@intel.com>
To: Fryderyk Mazurek <dedyk@go2.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041227171159.51454193BFA@r10.go2.pl>
References: <20041227171159.51454193BFA@r10.go2.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1104201851.18175.39.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 27 Dec 2004 21:44:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-27 at 12:11, Fryderyk Mazurek wrote:

> problem starts when I do reboot. On boot screen my bios can't detect
> my disk. Bios stops and nothing.

Does reboot work if the initial boot is with acpi=off?


