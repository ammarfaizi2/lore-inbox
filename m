Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275677AbTHOErL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 00:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275681AbTHOErL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 00:47:11 -0400
Received: from storm.he.net ([64.71.150.66]:51880 "HELO storm.he.net")
	by vger.kernel.org with SMTP id S275677AbTHOErK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 00:47:10 -0400
Date: Thu, 14 Aug 2003 21:47:01 -0700
From: Greg KH <greg@kroah.com>
To: Jonathan Morton <chromi@chromatix.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart failure on KT400
Message-ID: <20030815044701.GA29502@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Jonathan Morton <chromi@chromatix.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <3F3C2DA0.1030504@tooleweb.homelinux.com> <BD8AF95A-CEC1-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD8AF95A-CEC1-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-xfs (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:42:33AM +0100, Jonathan Morton wrote:
> 
> However, I did encounter a compilation problem with one of the USB 
> device drivers - not a major problem at present since that particular 
> device is attached to a different machine - but it does show that 2.6 
> isn't ready for primetime yet.  The major distros aren't going to make 
> that switch for a while.

Which device driver?  
What was the error?  
Did you report it anywhere?  


greg k-h
