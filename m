Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUCJVNn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbUCJVNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:13:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:10403 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262703AbUCJVNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:13:34 -0500
Date: Wed, 10 Mar 2004 13:08:40 -0800
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: Rusty Russell <rusty@au1.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       kai@germaschewski.name, sam@ravnborg.org, akpm@osdl.org
Subject: Re: Question on MODULE_VERSION macro
Message-ID: <20040310210840.GA21966@kroah.com>
References: <20040119214233.GF967@beaverton.ibm.com> <20040120005915.2A54A17DD8@ozlabs.au.ibm.com> <20040120011734.GB6309@kroah.com> <404F7F54.1000105@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F7F54.1000105@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 02:49:24PM -0600, Brian King wrote:
> Looks like the MODULE_VERSION macro is now in the tree.
> Greg, any status on the sysfs patch you mention below?

Already posted to lkml a week or so ago, and Rusty responded back with a
different patch.  I'll get to his response hopefully by the end of the
week...

thanks,

greg k-h
