Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVEUFaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVEUFaK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 01:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVEUFaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 01:30:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:24799 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261667AbVEUFaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 01:30:06 -0400
Date: Fri, 20 May 2005 22:35:58 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver
Message-ID: <20050521053558.GA23542@kroah.com>
References: <20050521001925.GQ5112@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050521001925.GQ5112@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2005 at 02:19:25AM +0200, Adrian Bunk wrote:
> Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> obsolete.
> 
> It seems to be time to remove it.

As much as I would like to agree with you, no, not yet.  Mark it as
going to go away in the Documenation/feature-removal.txt file 6-8 months
from now (or longer if people object, but no longer than a year) and
then after that time expires, we can delete it.

thanks,

greg k-h
