Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUEAFvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUEAFvm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 01:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUEAFvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 01:51:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:31892 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261998AbUEAFvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 01:51:39 -0400
Date: Fri, 30 Apr 2004 22:43:51 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: always store MODULE_VERSION("") data?
Message-ID: <20040501054351.GG21431@kroah.com>
References: <20040427145812.GA20421@lists.us.dell.com> <1083200122.9669.16.camel@bach> <20040430025558.GA26551@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430025558.GA26551@lists.us.dell.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:55:58PM -0500, Matt Domsch wrote:
> 
> Now to find GregKH's patch to export this stuff via sysfs...

Heh, it's in the archive.  I really need to spend the time and dig it up
and get it working again better.  Rusty sent the last version to me, and
hopefully I'll get to it next week...

thanks,

greg k-h
