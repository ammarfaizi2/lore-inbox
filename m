Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTLQO7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 09:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTLQO7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 09:59:30 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:39437 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S264433AbTLQO73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 09:59:29 -0500
Date: Wed, 17 Dec 2003 15:59:27 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple partition not detected with 2.6
Message-ID: <20031217145927.GB13205@win.tue.nl>
References: <20031215141746.GA27006@joebar.freealter.fr> <20031215170517.GA12267@win.tue.nl> <20031217112046.GA31709@joebar.freealter.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031217112046.GA31709@joebar.freealter.fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 12:20:46PM +0100, Ludovic Drolez wrote:

> I've attached a boot log.
> In fact it seems that it's not a partitions problem but a disk
> detection problem: the IDE controller is detected but not the disks...
> 
> The server is an HP-DL320 with integrated RAID IDE.

OK - in that case I can refer you to Bartlomiej Zolnierkiewicz,
our IDE maintainer.

