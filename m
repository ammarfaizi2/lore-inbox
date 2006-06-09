Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWFIGy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWFIGy3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 02:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWFIGy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 02:54:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:18338 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751387AbWFIGy1 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 02:54:27 -0400
From: Andi Kleen <ak@suse.de>
To: rohitseth@google.com
Subject: Re: [PATCH]:x86_64 setup.c - printing cmp related boottime information
Date: Fri, 9 Jun 2006 08:54:22 +0200
User-Agent: KMail/1.9.3
Cc: Linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1149796403.24364.7.camel@galaxy.corp.google.com>
In-Reply-To: <1149796403.24364.7.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606090854.22108.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 21:53, Rohit Seth wrote:
> Getting phys_proc_id and cpu_core_id information to be printed at boot
> time for AMD processors.  Also matching the Node related boot time
> information that gets printed for Intel and AMD processors for NUMA
> configurations.
Added. Thanks.
-Andi
