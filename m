Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTJ1XMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 18:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTJ1XMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 18:12:33 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:11783 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261825AbTJ1XMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 18:12:32 -0500
Subject: re: [PATCH] PS/2 mouse rate setting
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031028205549.29321.qmail@web14916.mail.yahoo.com>
References: <20031028205549.29321.qmail@web14916.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1067382741.841.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Wed, 29 Oct 2003 00:12:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 21:55, Jon Smirl wrote:
> I think the breakage in the PS/2 mouse driver came from today's Fedora update
> not the change in the kernel. 

Then, why can't I reproduce the problem with 2.6.0-test9-bk1?
2.6.0-test9-bk2 exhibits the slowness so something must have been
changed into the kernel.

