Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVBNWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVBNWCR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 17:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVBNWCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 17:02:17 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:9636 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261576AbVBNWCL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 17:02:11 -0500
Date: Mon, 14 Feb 2005 23:01:49 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Len Brown <len.brown@intel.com>
cc: Linus Torvalds <torvalds@osdl.org>, Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make ACPI_BLACKLIST_YEAR depend on ACPI
In-Reply-To: <1108413614.2092.5.camel@d845pe>
Message-ID: <Pine.LNX.4.61.0502142300460.6118@scrub.home>
References: <200502141130.51901@bilbo.math.uni-mannheim.de> 
 <Pine.LNX.4.58.0502140801570.15516@ppc970.osdl.org> <1108413614.2092.5.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 14 Feb 2005, Len Brown wrote:

> Re: ACPI_BLACKLIST_YEAR depending on ACPI or ACPI_INTERPRETER -- either
> are fine.

Note that a patch that fixes this and a little more is waiting in -mm and 
Sam's tree.

bye, Roman
