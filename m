Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWIAIVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWIAIVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWIAIVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:21:35 -0400
Received: from ns.suse.de ([195.135.220.2]:10628 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750786AbWIAIVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:21:35 -0400
From: Andi Kleen <ak@suse.de>
To: adurbin@google.com
Subject: Re: [PATCH] x86_64: insert IOAPIC(s) and Local APIC into resource map
Date: Fri, 1 Sep 2006 10:19:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060831233352.GB21338@google.com>
In-Reply-To: <20060831233352.GB21338@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011019.16082.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 01:33, adurbin@google.com wrote:
> 
> This patch places the IOAPIC(s) and the Local APIC specified by ACPI
> tables into the resource map. The APICs will then be visible within
> /proc/iomem

Applied thanks

-Andi
