Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272229AbTHRSQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272230AbTHRSQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:16:09 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:35847 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S272229AbTHRSQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:16:05 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: ACPI still doesn't work
Date: Mon, 18 Aug 2003 18:34:29 +0100
User-Agent: KMail/1.5.3
References: <3F40C9C3.8090105@comcast.net>
In-Reply-To: <3F40C9C3.8090105@comcast.net>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308181834.29879.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 Aug 2003 13:42, David van Hoose wrote:
> Have the ACPI and IOAPIC patches for 2.4.22-rc2 been applied to 2.6? I
> believe these patches fixed ACPI under 2.4 for my system.

I am not a kernel developer, but for what it's worth, I applied the ACPI 
patch from acpi.sourceforge.net for 2.6.0-test2 to my test2 kernel, then 
patched it up to test3, and my ACPI works at least as well as it did under 
2.4.21.

I imagine that you could cleanly apply the test2 ACPI patch to the test3 
sources, so that might be worth a try for you, or you could wait a couple of 
days and see if the ACPI folks produce a new patch for test3...

Cheers,

Matt

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
