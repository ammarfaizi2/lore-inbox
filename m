Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUH2FM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUH2FM5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 01:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUH2FM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 01:12:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:25224 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266199AbUH2FM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 01:12:56 -0400
Date: Sat, 28 Aug 2004 22:01:07 -0700
From: Greg KH <greg@kroah.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org, steve@steve-parker.org
Subject: Re: PWC issue
Message-ID: <20040829050107.GB19005@kroah.com>
References: <200408290206.i7T267e16663@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408290206.i7T267e16663@adam.yggdrasil.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 07:06:07PM -0700, Adam J. Richter wrote:
> 	I hasten to add that, while I think that the binary firmware
> images that I believe violate the GPL should be removed from the
> kernel immediately, there are also some binary firmware images
> covered by GPL compatible copying permissions, which include
> source code, such as xircom_pgs.S.  For the GPL-compatible
> firmware binaries that include source code, I have no problem
> with a six month warning period.

I understand that we currently disagree about this point, and am
comfortable with our disagreement :)

So, what do you want to do?  If no one sends me a patch to even provide
the option of the images moving out of the kernel at some point in time,
it's not going to get done.

thanks,

greg k-h
