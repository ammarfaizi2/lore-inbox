Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUEHA0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUEHA0B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUEHAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:23:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:57987 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263942AbUEHAWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:22:01 -0400
Date: Fri, 7 May 2004 16:47:23 -0700
From: Greg KH <greg@kroah.com>
To: dongzai007@sohu.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb_driver
Message-ID: <20040507234723.GA15982@kroah.com>
References: <5021040.1083925834604.JavaMail.postfix@mx0.mail.sohu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5021040.1083925834604.JavaMail.postfix@mx0.mail.sohu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 06:30:34PM +0800, dongzai007@sohu.com wrote:
> I am developing a usb device driver in linux 2.4.
> 
> I have a foolish question, how can linux system differentiate usb
> drivers according to PID&VID.

Please read the Linux USB documentation, it is all in the kernel tree.

greg k-h
