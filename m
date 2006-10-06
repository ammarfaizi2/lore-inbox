Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWJFFVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWJFFVx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWJFFVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:21:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:14237 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932584AbWJFFVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:21:52 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Jan Dittmer <jdi@l4x.org>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, fifth try
Date: Fri, 6 Oct 2006 01:23:14 -0400
User-Agent: KMail/1.8.2
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, dtor@insightbb.com, akpm@osdl.org
References: <20061004024927.GA27716@ecstasy.ring2.lan> <45235042.4090201@l4x.org>
In-Reply-To: <45235042.4090201@l4x.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610060123.15013.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 02:10, Jan Dittmer wrote:
> Lennart Poettering wrote:

> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig

> This part is still spaces only. The help text should be indented
> by tab + 2 spaces.

fixed.
thanks,
-Len
