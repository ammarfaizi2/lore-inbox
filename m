Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031145AbWFOTGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031145AbWFOTGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 15:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031140AbWFOTGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 15:06:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8968 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1031144AbWFOTGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 15:06:10 -0400
Date: Thu, 15 Jun 2006 20:06:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: Re: [Ubuntu PATCH] 8250_pnp:  Add support for other Wacom tablets
Message-ID: <20060615190604.GD8694@flint.arm.linux.org.uk>
Mail-Followup-To: Randy Dunlap <randy.dunlap@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <4491BC77.4040804@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4491BC77.4040804@oracle.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 01:00:55PM -0700, Randy Dunlap wrote:
> From: Ben Collins <bcollins@ubuntu.com>
> 
> [UBUNTU:8250_pnp] Add support for other Wacom tablets that are around
> 
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=6a242b6c279af7805a6cca8f39dbc5bfe1f78cd1
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

Is there a way to "pick" this change from that git tree and throw it
directly into another git tree, preserving all the metadata?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
