Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVB1BKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVB1BKw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 20:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVB1BKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 20:10:51 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:65230 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261545AbVB1BKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 20:10:48 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Jean-Marc Valin <Jean-Marc.Valin@usherbrooke.ca>
Subject: Re: ext3 bug
Date: Sun, 27 Feb 2005 20:10:46 -0500
User-Agent: KMail/1.7.92
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <1109487896.8360.16.camel@localhost> <200502271406.30690.kernel-stuff@comcast.net> <1109545130.7940.2.camel@localhost>
In-Reply-To: <1109545130.7940.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502272010.46744.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 February 2005 05:58 pm, Jean-Marc Valin wrote:
> I did use a stock 2.6.10 kernel (I said custom in the sense that it
> wasn't a Debian kernel). After a reboot, I was able to run fsck on the
> disk (many, many errors) and it went fine after.

Hmm.. So that error is not FC3 specific, it is present in stock 2.6.10 as 
well.  Also - This is on a USB disk, right? If so, the error may re-surface. 
Try upgrading to latest kernel if possible. 

Parag
