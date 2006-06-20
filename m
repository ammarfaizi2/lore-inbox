Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965442AbWFTD2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965442AbWFTD2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 23:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965447AbWFTD2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 23:28:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965442AbWFTD2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 23:28:08 -0400
Date: Mon, 19 Jun 2006 20:27:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: randy.dunlap@oracle.com, linux-kernel@vger.kernel.org, maxk@qualcomm.com
Subject: Re: [Ubuntu PATCH] bluetooth/hci_usb: Fix failures for
 suspend/resume
Message-Id: <20060619202710.5b3e0cad.akpm@osdl.org>
In-Reply-To: <1150450336.8438.0.camel@aeonflux.holtmann.net>
References: <4491BC5A.3020306@oracle.com>
	<1150450336.8438.0.camel@aeonflux.holtmann.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2006 11:32:15 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Randy,
> 
> > [UBUNTU:bluetooth] Fix failures for suspend/resume
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=58db2683478e24009dbae33ea76beafe47b356bb
> > 
> > Plus whitespace cleanups by Randy Dunlap.
> 
> this one is in my queue, but I missed the merge window.
> 

I hope your version has the CONFIG_PM wrappers..

Where's your queue?
