Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271263AbUJVMXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271263AbUJVMXe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271260AbUJVMXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:23:33 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:55813 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S271263AbUJVMXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:23:30 -0400
Date: Fri, 22 Oct 2004 14:23:27 +0200
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: Buggy DSDTs policy ?
Message-ID: <20041022122326.GA69381@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the policy w.r.t broken DSDTs and the ACPI subsystem?
Specifically, which of these two options is right:

1- Provide a non-buggy DSDT to the kernel
2- Make the ACPI subsystem tolerant of the bugs

The option 3, have all biosen over the world fixed is a nice fantasy,
but nothing else.

If 1, we need to put a mechanism for that in the official kernel.

If 2, I'll start working on patches to make the laptop I play with
work as-is.

So, which it is?

  OG.
