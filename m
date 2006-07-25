Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWGYW3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWGYW3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWGYW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:29:13 -0400
Received: from mx1.suse.de ([195.135.220.2]:4031 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932504AbWGYW3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:29:12 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: VIA x86-64 bootlogs needed
Date: Wed, 26 Jul 2006 00:18:04 +0200
User-Agent: KMail/1.9.3
Cc: Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org
References: <200607251824.30504.ak@suse.de> <1153848759.2661.5.camel@entropy>
In-Reply-To: <1153848759.2661.5.camel@entropy>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607260018.04851.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> MSI Master2-FAR with VIA K8T800, kernel-2.6.17-1.2157_FC5

Thanks.

> With any luck, this APIC rework will fix this board's habit of
> spontaneously turning off interrupts at the IOAPIC level without the
> kernel's knowledge.

Unlikely unfortunately. How does it look like when they get turned off?

-Andi
