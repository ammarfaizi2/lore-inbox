Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266568AbUBDV0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266566AbUBDVYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:24:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:7144 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266568AbUBDVW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:22:56 -0500
Date: Wed, 4 Feb 2004 13:22:53 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 2013] New: Oops from create_dir (sysfs)
Message-ID: <20040204212253.GA3897@kroah.com>
References: <1075926442.3026.37.camel@verve> <20040204204811.GA3992@us.ibm.com> <1075928072.3026.47.camel@verve>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075928072.3026.47.camel@verve>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 02:54:32PM -0600, John Rose wrote:
> > The kobject code quickly pointed out the flaw in your code.  
> 
> That it did, but an "already exists" return code from kobject_add would
> have pointed it out more quickly :)

Patches are always gladly accepted :)

thanks,

greg k-h
