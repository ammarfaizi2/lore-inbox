Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbTCMANH>; Wed, 12 Mar 2003 19:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTCMANH>; Wed, 12 Mar 2003 19:13:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14857 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261384AbTCMANF>;
	Wed, 12 Mar 2003 19:13:05 -0500
Date: Wed, 12 Mar 2003 16:12:53 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] kobject support for LSM core (v2)
Message-ID: <20030313001253.GF27256@kroah.com>
References: <20030310001310.GU3917@pasky.ji.cz> <20030310064738.GD6512@kroah.com> <20030312232027.GQ7397@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312232027.GQ7397@pasky.ji.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13, 2003 at 12:20:27AM +0100, Petr Baudis wrote:
> The second version of the patch follows...

Much nicer, and I would agree to add this patch to the kernel, if there
was actually a user for it :)

Mind converting one of the exsting LSM modules to use this sysfs
subsystem?

thanks,

greg k-h
