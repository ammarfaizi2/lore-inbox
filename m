Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbREUQXz>; Mon, 21 May 2001 12:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbREUQXp>; Mon, 21 May 2001 12:23:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57092 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261558AbREUQXe>; Mon, 21 May 2001 12:23:34 -0400
Subject: Re: ACPI - console problems 2.4.4
To: npapadon@yahoo.com (Nick Papadonis)
Date: Mon, 21 May 2001 17:19:54 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3ae46fzgs.fsf@yahoo.com> from "Nick Papadonis" at May 21, 2001 12:17:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151sPS-0000Sf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is anyone having problems with ACPI causing console problems in kernel
> 2.4.4 w/ Intel's patches?   When watching my system boot over the
> serial console, things work fine.  When looking at my VAIO-FX140's
> LCD, my console no longer updates after ACPI starts initializing _INI methods.

Generally a good rule is 'dont bother with ACPI'. But do let Andrew Grover
know how it fails on your box
