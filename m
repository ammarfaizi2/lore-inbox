Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVFJA6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVFJA6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 20:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVFJA6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 20:58:19 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:55719 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262335AbVFJA6R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 20:58:17 -0400
X-ORBL: [63.202.173.158]
Date: Thu, 9 Jun 2005 17:58:12 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: MMC ioctl or sysfs interface?
Message-ID: <101040.57feb9cd101d268ffd2ffe2d314867d3.ANY@taniwha.stupidest.org>
References: <42A83F59.7090509@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A83F59.7090509@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2005 at 03:08:41PM +0200, Pierre Ossman wrote:

> MMC cards have the feature to lock down cards using a special
> password.  When the cards is locked it will not accept any commands
> except lock-related ones.

IDE disks can do this too --- is it the same interface?
