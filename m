Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbTLZXaK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbTLZX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:28:44 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:28424 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265264AbTLZX1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:27:30 -0500
Date: Sat, 27 Dec 2003 00:38:55 +0100
To: Jos Hulzink <josh@stack.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.7 (future kernel) wish
Message-ID: <20031226233855.GA476@hh.idb.hist.no>
References: <200312232342.17532.josh@stack.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312232342.17532.josh@stack.nl>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 11:42:17PM +0100, Jos Hulzink wrote:
> Hi,
> 
> First of all... Compliments about 2.6.0. It is a superb kernel, with very few 
> serious bugs, and for me it runs stable like a rock from the very first 
> moment.
> 
> As an end user, Linux doesn't give me a good feeling on one particular item 
> yet: Error handling. 
> 
> What do I mean ? Well... for example: Pull out your USB stick with a mounted 
> fs on it. 

You aren't supposed to do that.  If you want to pull devices like that,
with no warning, access them in other ways than mounting.  
mtools are nice when you don't want to mount/umount floppies - a
similiar approach should work for usb sticks too.



Helge Hafting
