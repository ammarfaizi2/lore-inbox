Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbUAFQOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUAFQOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:14:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3281 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261799AbUAFQOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:14:19 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200401061614.i06GE5mZ030970@devserv.devel.redhat.com>
To: Martin Hicks <mort@bork.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Weird problems with printer using USB
In-Reply-To: <mailman.1073332322.31520.linux-kernel2news@redhat.com>
References: <20040105192430.GA15884@DervishD> <mailman.1073332322.31520.linux-kernel2news@redhat.com>
Date: Tue, 6 Jan 2004 11:14:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In rhat.general.linux-kernel, Martin Hicks <mort@bork.org> wrote:
> On Mon, Jan 05, 2004 at 08:24:30PM +0100, DervishD wrote:

> I'm getting this same error when printing anything but the smallest
> print job to an HP DeskJet 3550 USB.  Using latest RH9 errata packages.

Please never use the phrase "Using latest ... errata" again.
NEVER. How am I supposed to know what kernel you are using?!
Instead, write "Using 2.4.23-foo", or paste /proc/version.

And once we are at it, file a bug to RH Bugzilla. Or better yet,
upgrade to FC1 and file a bug.

-- Pete
