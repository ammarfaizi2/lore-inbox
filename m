Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271094AbTHCHbT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271116AbTHCHbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:31:19 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:59410 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S271094AbTHCHbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:31:18 -0400
Date: Sun, 3 Aug 2003 09:31:15 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Ruben Puettmann <ruben@puettmann.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI Error with 2.4.20-pre10 on ibm thinkpad
Message-ID: <20030803073115.GC679@alpha.home.local>
References: <20030803002438.GA15097@puettmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030803002438.GA15097@puettmann.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sun, Aug 03, 2003 at 02:24:38AM +0200, Ruben Puettmann wrote:
> Local APIC disabled by BIOS -- reenabling.
> Found and enabled local APIC!

ACPI on my VAIO was a bit jerky until I disabled local APIC. It now seems to
work OK. BTW, this notebook would never reboot with local APIC ON ! The BIOS
cannot access the hard disk anymore.

Even if they're not the same systems, perhaps you should try to disable APIC
on your thinkpad ?

Cheers,
Willy

