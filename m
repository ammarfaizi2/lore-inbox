Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269474AbUI3VIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269474AbUI3VIY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 17:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269498AbUI3VIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 17:08:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28892 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S269474AbUI3VIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 17:08:20 -0400
Subject: Re: Compiling a 2.4 driver under 2.6
From: Josh Boyer <jdub@us.ibm.com>
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E35019397@constellation.doubledimension.com>
References: <E6456D527ABC5B4DBD1119A9FB461E35019397@constellation.doubledimension.com>
Content-Type: text/plain
Message-Id: <1096578498.13342.0.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 30 Sep 2004 16:08:18 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-30 at 15:31, Brian McGrew wrote:
> Hello all:
> 
> We've got a device driver that we currently use under the 2.4.20 kernel and it works.  I'm trying to get the same driver compiled up under the 2.6.8 (Fedora Core 2) kernel and getting a lot of errors.  I'm no expert software engineer or kernel guy, so any help would be great.  I've included the error output as well as the drive source.
> 

This might help to start with:

http://lwn.net/Articles/driver-porting/

josh

