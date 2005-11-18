Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161207AbVKRUxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161207AbVKRUxB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161206AbVKRUxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:53:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:13508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161207AbVKRUw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:52:59 -0500
Date: Fri, 18 Nov 2005 12:37:27 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-ID: <20051118203727.GA23151@kroah.com>
References: <20051117111807.6d4b0535.akpm@osdl.org> <200511180743.44838.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511180743.44838.tomlins@cam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 07:43:44AM -0500, Ed Tomlinson wrote:
> On Thursday 17 November 2005 14:18, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
> 
> Hi,
> 
> Any ideas why the mousedev module does not load automaticly with 15-rc1-mm1?

Are you using debian?
If so, what version of udev are you using?  There are some known
reported problems with this, so I would suggest referring to the udev
bug list.

If you aren't using Debian, please let us know.  Also, what version of
udev are you using?

thanks,

greg k-h
