Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbTITKNU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 06:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTITKNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 06:13:20 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:20486 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261815AbTITKNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 06:13:19 -0400
Date: Sat, 20 Sep 2003 12:13:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Anoop <anoopr@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partition Error in 2.6.0test5
Message-ID: <20030920121317.A3483@pclin040.win.tue.nl>
References: <00d001c37f19$2723bf70$22646b81@sigma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00d001c37f19$2723bf70$22646b81@sigma>; from anoopr@myrealbox.com on Fri, Sep 19, 2003 at 08:47:27PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 08:47:27PM -0500, Anoop wrote:

> Hi, My name is Anoop. I have a problem with the 2.6.0test5 kernel. It gives
> me an error saying that the partitions are not aligned, when I try to print
> the partition table, using fdisk. I have a Pheonix Bios and a 40GB HDD,
> running on my laptop. I have already disabled the "Auto-resize geometry"
> option in the kernel.

Ignore the warning - it is not an error and is completely harmless.

