Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbTLJXlY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTLJXlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:41:24 -0500
Received: from gaia.cela.pl ([213.134.162.11]:53765 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264271AbTLJXlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:41:21 -0500
Date: Thu, 11 Dec 2003 00:40:59 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
In-Reply-To: <yw1xd6aw4ge3.fsf@kth.se>
Message-ID: <Pine.LNX.4.44.0312110040160.3331-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't see why it wouldn't be a good thing for regular systems
> > also. Saving memory is usually a good idea.
> 
> The biggest modules are about 100k.  Saving 100k of 1 GB doesn't
> really seem worth any effort.

so let's cut kernel module support period and make the kernel fully 
monolithic.  this will also solve the binary module vs gpl issue and 
everyone will be happy...

cheers,
maze.


