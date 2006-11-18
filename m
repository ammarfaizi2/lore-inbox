Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754285AbWKRIt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285AbWKRIt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 03:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756242AbWKRIt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 03:49:29 -0500
Received: from mx1.suse.de ([195.135.220.2]:47034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754285AbWKRIt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 03:49:29 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Date: Sat, 18 Nov 2006 09:29:12 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com>
In-Reply-To: <20061117225953.GU15449@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611180929.12643.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 November 2006 23:59, Vivek Goyal wrote:

> + *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)

Normally it's not ok to take sole copyright on code that you mostly copied ...

-Andi
