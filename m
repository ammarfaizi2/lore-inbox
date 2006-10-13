Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWJMOtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWJMOtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 10:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWJMOtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 10:49:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15117 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750981AbWJMOtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 10:49:01 -0400
Date: Fri, 13 Oct 2006 14:48:44 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Burman Yan <yan_952@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HP mobile data protection system driver take 2
Message-ID: <20061013144844.GB5512@ucw.cz>
References: <BAY20-F24D6EADDDBE9963D7307A4D80A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY20-F24D6EADDDBE9963D7307A4D80A0@phx.gbl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-10-06 15:10:29, Burman Yan wrote:
> Hi, All.
> 
> Thanks for the remarks on my previous post.
> Here is the driver for HP Mobile Data Protection System 
> with the following changes:
> 1) Fixed tabs from 8 spaces to tabs
> 2) Removed C++ style comments
> 3) Made some functions return void if their return value 
> is not checked anyway
> 4) Moved the interface from proc to sysfs
> 5) Made the sysfs interface similar to hdaps's so that 
> hdapsd could be used perhaps with small modifications
> 
> I would like to hear your remarks on this version.

Please inline patches.

Is sysfs interface compatible to hdaps one?

-- 
Thanks for all the (sleeping) penguins.
