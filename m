Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263267AbVCKLFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbVCKLFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 06:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbVCKLFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 06:05:17 -0500
Received: from [81.2.110.250] ([81.2.110.250]:39830 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S263267AbVCKLFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 06:05:14 -0500
Subject: Re: [PATCH] Support for GEODE CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: dvrabel@cantab.net, lsorense@csclub.uwaterloo.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050310174206.6b2f27b8.akpm@osdl.org>
References: <200503081935.j28JZ433020124@hera.kernel.org>
	 <1110387668.28860.205.camel@localhost.localdomain>
	 <20050309173344.GD17865@csclub.uwaterloo.ca>
	 <1110405563.3072.250.camel@localhost.localdomain>
	 <422F8623.4030405@cantab.net>
	 <1110413198.3116.278.camel@localhost.localdomain>
	 <20050310174206.6b2f27b8.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110538950.15927.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Mar 2005 11:02:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-11 at 01:42, Andrew Morton wrote:
> So..  did we end up deciding that the Geode patch should be reverted
> wholesale?

Either revert it or make it Geode GX and correct the options set. I've
no problem with a Geode option that sets the right options 8)

