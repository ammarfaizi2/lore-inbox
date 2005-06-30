Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbVF3JRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbVF3JRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262911AbVF3JRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:17:34 -0400
Received: from mail.zmailer.org ([62.78.96.67]:746 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262910AbVF3JRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:17:31 -0400
Date: Thu, 30 Jun 2005 12:17:27 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ville Sundell <ville.sundell@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Build-in XML support?
Message-ID: <20050630091727.GB22165@mea-ext.zmailer.org>
References: <ec2c5c2205062903511d62d6bf@mail.gmail.com> <ec2c5c2205063002091ba9e818@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2c5c2205063002091ba9e818@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:09:35PM +0300, Ville Sundell wrote:
> Sorry guys!
> I say it wrong way, I mean:
> Other programs would like use build-in and "standard" linux XML-parser.
> 
> It would make standard way to read xml-files in Linux?
> Advertise speech:
>     No more 1 000 different XML readers, only one, and people can
> make it better :D

And why should it be in KERNEL ?   You are writing in
Linux-Kernel -list about it, after all ?

Kernel sources do not carry things like glibc, on which all
applications do rely on rather heavily.  Why should there
be XML-support, which is not needed by all programs ?

> Michael Buesch, that source you paste, it is good, it is better than mine! :)
> 
> Comments please!
> -Ville Sundell

/Matti Aarnio
