Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWFFNxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWFFNxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWFFNxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:53:50 -0400
Received: from rtr.ca ([64.26.128.89]:49291 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932168AbWFFNxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:53:49 -0400
Message-ID: <448588E5.1070702@rtr.ca>
Date: Tue, 06 Jun 2006 09:53:41 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nathans@sgi.com,
       davem@davemloft.net
Subject: Re: [RFC] Update sysctl documentation
References: <20060606035833.bee909af.diegocg@gmail.com>
In-Reply-To: <20060606035833.bee909af.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I promised, I've updated all the documentation concerning sysctls.
> 
> First of all: the formatting I've choosen is to recreate the structure
> of /proc/sys/* and put the documentation for every value in a separated
> file,

Thanks for doing this.  But I must say, having a zillion tiny little
files makes it very difficult to browse the documentation.

Perhaps one file per subdirectory or subsystem?  That way, related values
stay together and the end-user of the documentation can figure it out easier.

Cheers
