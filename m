Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTJGSYi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTJGSYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:24:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59620 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262671AbTJGSYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:24:36 -0400
Date: Tue, 7 Oct 2003 19:24:35 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Subject: Re: devfs vs. udev
Message-ID: <20031007182435.GW7665@parcelfarce.linux.theplanet.co.uk>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <20031007175310.GC1956@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007175310.GC1956@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 10:53:10AM -0700, Greg KH wrote:
 
> A few things happened:
> 	- the devfs maintainer/author disappeared and stoped maintaining
> 	  the code.
> 	- devfs was found to have unfixable bugs
> 	- it was determined that the same thing could be done in
> 	  userspace (like udev.)

It went more like
	
	- it was determined that the same thing could be done in
	  userspace
	- devfs had been shoved into the tree in hope that its quality will
	  catch up
	- devfs was found to have fixable and unfixable bugs
	- the former had stayed around for many months with maintainer claiming
	  that everything works fine
	- the latter had stayed, period.
	- the devfs maintainer/author disappeared and stoped maintaining
	  the code.
