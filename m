Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269584AbUI3WXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269584AbUI3WXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 18:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269590AbUI3WXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 18:23:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:60041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269584AbUI3WXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 18:23:04 -0400
Date: Thu, 30 Sep 2004 15:22:44 -0700
From: Greg KH <greg@kroah.com>
To: Brian McGrew <Brian@doubledimension.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling a 2.4 driver under 2.6
Message-ID: <20040930222243.GA24619@kroah.com>
References: <E6456D527ABC5B4DBD1119A9FB461E35019397@constellation.doubledimension.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6456D527ABC5B4DBD1119A9FB461E35019397@constellation.doubledimension.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2004 at 01:31:50PM -0700, Brian McGrew wrote:
> /* license info */
> MODULE_LICENSE("Proprietary");

Ok, and you're allowed to post this to lkml?

<snip>

>     /* stealing code from cciss.c - thanks compaq! */

Ah, how nice of you to put GPL code into your closed source driver.
Care to get a head start before the lawyers start running after you?  :)

greg k-h
