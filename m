Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754416AbWKRKzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbWKRKzu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754418AbWKRKzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:55:50 -0500
Received: from ozlabs.org ([203.10.76.45]:51170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1754411AbWKRKzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:55:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17758.59055.613106.945095@cargo.ozlabs.ibm.com>
Date: Sat, 18 Nov 2006 21:55:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
In-Reply-To: <200611180929.12643.ak@suse.de>
References: <20061117223432.GA15449@in.ibm.com>
	<20061117225953.GU15449@in.ibm.com>
	<200611180929.12643.ak@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> On Friday 17 November 2006 23:59, Vivek Goyal wrote:
> 
> > + *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)
> 
> Normally it's not ok to take sole copyright on code that you mostly copied ...

Is this a case where the original had no copyright notice?  If so,
what do you suggest Vivek should have done?

Paul.
