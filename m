Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWJWHnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWJWHnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 03:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWJWHnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 03:43:40 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:54161 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751694AbWJWHnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 03:43:39 -0400
Date: Mon, 23 Oct 2006 09:43:36 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86-64: using cpu_online_map instead of APIC_ALL_CPUS
Message-ID: <20061023074335.GM4354@rhun.haifa.ibm.com>
References: <86802c440610220942m4fc77edbi7b6d62a2b2b378c5@mail.gmail.com> <m1k62sz150.fsf@ebiederm.dsl.xmission.com> <86802c440610221258q29b19839i7290b628424f7dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610221258q29b19839i7290b628424f7dba@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2006 at 12:58:57PM -0700, Yinghai Lu wrote:

> Muli,
> 
> Can you test this one?

I assume it was superceded by a later patch, please let me know if it
wasn't.

Cheers,
Muli
