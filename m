Return-Path: <linux-kernel-owner+w=401wt.eu-S1030228AbXAKImM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbXAKImM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbXAKImM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:42:12 -0500
Received: from hera.kernel.org ([140.211.167.34]:34985 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030228AbXAKImL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:42:11 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: jayakumar.acpi@gmail.com
Subject: Re: [PATCH 2.6.19 1/1] input: Atlas button driver
Date: Thu, 11 Jan 2007 03:40:35 -0500
User-Agent: KMail/1.9.5
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       dmitry.torokhov@gmail.com, akpm@osdl.org
References: <200701110519.l0B5Jl5B026909@localhost.localdomain>
In-Reply-To: <200701110519.l0B5Jl5B026909@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701110340.35427.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jaya,
Thanks for consolidating the earlier patches
so that this driver now only reports input events
and does not touch /proc/acpi.

Thanks for fixing the status issue.

Acked-by: Len Brown <len.brown@intel.com>
