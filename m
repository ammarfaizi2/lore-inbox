Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263083AbVGNTDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263083AbVGNTDO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGNTBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:01:02 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:29859 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S261654AbVGNTAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:00:05 -0400
Date: Thu, 14 Jul 2005 13:00:01 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: yhlu <yinghailu@gmail.com>
cc: Stefan Reinauer <stepan@openbios.org>, LinuxBIOS <linuxbios@openbios.org>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA support for dual core Opteron
In-Reply-To: <2ea3fae10507141058c476927@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov>
References: <2ea3fae10507141058c476927@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if there is any chance of getting along without ACPI entries that is best.  
Linux did do this once already, for SMP K8: K8 can boot and run NUMA
without an SRAT table. What more is needed for dual core, and could Linux
support in this area be extended?

ron

