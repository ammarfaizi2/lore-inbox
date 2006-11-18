Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754424AbWKRK6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754424AbWKRK6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbWKRK6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:58:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:2258 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754420AbWKRK6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:58:34 -0500
From: Andi Kleen <ak@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Date: Sat, 18 Nov 2006 11:58:14 +0100
User-Agent: KMail/1.9.5
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
References: <20061117223432.GA15449@in.ibm.com> <200611180929.12643.ak@suse.de> <17758.59055.613106.945095@cargo.ozlabs.ibm.com>
In-Reply-To: <17758.59055.613106.945095@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611181158.15114.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 November 2006 11:55, Paul Mackerras wrote:
> Andi Kleen writes:
> 
> > On Friday 17 November 2006 23:59, Vivek Goyal wrote:
> > 
> > > + *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)
> > 
> > Normally it's not ok to take sole copyright on code that you mostly copied ...
> 
> Is this a case where the original had no copyright notice?  If so,
> what do you suggest Vivek should have done?

The head.S code this was copied from definitely had a copyright.

-Andi
