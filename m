Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWJPKg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWJPKg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWJPKg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:36:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:21187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751092AbWJPKg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:36:28 -0400
From: Andi Kleen <ak@suse.de>
To: "Yinghai Lu" <yinghai.lu@amd.com>
Subject: Re: [PATCH] remove duplicated cpu_mask_to_apicid in x86_64 smp.h
Date: Mon, 16 Oct 2006 12:21:59 +0200
User-Agent: KMail/1.9.3
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       yhlu.kernel@gmail.com
References: <86802c440610140019u6697e4e5kbac442910c9e86c8@mail.gmail.com>
In-Reply-To: <86802c440610140019u6697e4e5kbac442910c9e86c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161221.59393.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 October 2006 09:19, Yinghai Lu wrote:
> inline function cpu_mask_to_apicid in smp.h is duplicated with macro
> in mach_apic.h.
Added thanks

-Andi
