Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUDHQpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUDHQpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:45:08 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:45975 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262042AbUDHQpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:45:05 -0400
Date: Thu, 08 Apr 2004 09:56:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [patch 0/3] memory hotplug prototype
Message-ID: <4200000.1081443395@flay>
In-Reply-To: <20040408091610.65C29706C3@sv1.valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp><29700000.1081361575@flay> <20040408091610.65C29706C3@sv1.valinux.co.jp>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At Wed, 07 Apr 2004 11:12:55 -0700,
> Martin J. Bligh <mbligh@aracnet.com> wrote:
>> 
>> > This is an updated version of memory hotplug prototype patch, which I
>> > have posted here several times.
>> 
>> I really, really suggest you take a look at Dave McCracken's work, which
>> he posted as "Basic nonlinear for x86" recently. It's going to be much
>> much easier to use this abstraction than creating 1000s of zones ...
> 
> Well, I think his patch is orthogonal to mine.  My ultimate target
> is IA64 and it will only support node-sized memory hotplugging.

Are you saying you're only creating a patch for ia64 only, rather than
an arch-independant one?

M.

