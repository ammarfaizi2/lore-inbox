Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVCUXmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVCUXmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVCUXms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:42:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:38367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262191AbVCUXl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:41:28 -0500
Date: Mon, 21 Mar 2005 15:41:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dvrabel@cantab.net, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org, kianusch@sk-tech.net
Subject: Re: [PATCH] Support for GEODE CPUs
Message-Id: <20050321154105.3c24c88e.akpm@osdl.org>
In-Reply-To: <1110538950.15927.15.camel@localhost.localdomain>
References: <200503081935.j28JZ433020124@hera.kernel.org>
	<1110387668.28860.205.camel@localhost.localdomain>
	<20050309173344.GD17865@csclub.uwaterloo.ca>
	<1110405563.3072.250.camel@localhost.localdomain>
	<422F8623.4030405@cantab.net>
	<1110413198.3116.278.camel@localhost.localdomain>
	<20050310174206.6b2f27b8.akpm@osdl.org>
	<1110538950.15927.15.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Gwe, 2005-03-11 at 01:42, Andrew Morton wrote:
> > So..  did we end up deciding that the Geode patch should be reverted
> > wholesale?
> 
> Either revert it or make it Geode GX and correct the options set. I've
> no problem with a Geode option that sets the right options 8)

Two weeks, no patch.  It looks like we'll be reverting it.
