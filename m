Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTJKRpp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTJKRpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:45:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10625 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263340AbTJKRpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:45:44 -0400
Date: Sat, 11 Oct 2003 10:39:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: Kevin Curtis <kevin.curtis@farsite.co.uk>
Cc: khc@pm.waw.pl, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] [PATCH] generic HDLC Cisco bugfix
Message-Id: <20031011103951.78b06186.davem@redhat.com>
In-Reply-To: <7C078C66B7752B438B88E11E5E20E72E25CA91@GENERAL.farsite.co.uk>
References: <7C078C66B7752B438B88E11E5E20E72E25CA91@GENERAL.farsite.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Oct 2003 16:56:00 +0100
Kevin Curtis <kevin.curtis@farsite.co.uk> wrote:

> Is this only for 2.6.x or does it also include 2.4.x and 2.2.x
> I ask this because I will need to submit a patch for the farsync WAN drivers
> soon which will need to be applied to all three kernels.

For 2.4.x too, yes.  As for 2.2.x I want nothing to do with
that tree, and it's in "OOPS fixers only" mode these days.
