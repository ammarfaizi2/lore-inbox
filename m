Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbTJNXen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbTJNXen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 19:34:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:59021 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261592AbTJNXem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 19:34:42 -0400
Date: Tue, 14 Oct 2003 16:22:03 -0700
From: Greg KH <greg@kroah.com>
To: Chandra Konakalla <chandrak@broadbus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB mass storage device - jumpdrive 2.0 pro - linux driver
Message-ID: <20031014232203.GB18202@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <3B83C5E7EAB53F44A16CDFB70F9E4BF30CCB3C@btiexch01.broadbus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B83C5E7EAB53F44A16CDFB70F9E4BF30CCB3C@btiexch01.broadbus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 05:51:38PM -0400, Chandra Konakalla wrote:
> Hello 
> 
> I am using the above Lexar made jumpdrive 2.0 pro mass storage device
> with my Host controller ISP 1161A. 
> 
> We are using Linux 2.4.21 with powePC environment.  Following are the
> console output results for different commands.

Do you have the sd module loaded?

thanks,

greg k-h
