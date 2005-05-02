Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVEBUTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVEBUTp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVEBUTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:19:45 -0400
Received: from mail.kroah.org ([69.55.234.183]:61386 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261758AbVEBUTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:19:33 -0400
Date: Mon, 2 May 2005 13:15:07 -0700
From: Greg KH <greg@kroah.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] I2C rtc8564.c remove duplicate include (whitespace fixed)
Message-ID: <20050502201507.GB5938@kroah.com>
References: <425125EC.6080201@anagramm.de> <20050409131643.4269911a.khali@linux-fr.org> <425A481A.7020801@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425A481A.7020801@anagramm.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 11:49:14AM +0200, Clemens Koller wrote:
> [PATCH] I2C rtc8564.c remove duplicate include
> 
> Trivial fix: removes duplicate include line.
> Patch applies to: 2.6.11.x
> 
> (This is my very first patch to the linux-kernel, so let me
> start with small things first...)
> 
> Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>

Applied, thanks.

greg k-h
