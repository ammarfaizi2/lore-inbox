Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVDKVJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVDKVJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDKVJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:09:33 -0400
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:63240 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261938AbVDKVJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:09:25 -0400
Date: Tue, 12 Apr 2005 00:10:06 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Clemens Koller <clemens.koller@anagramm.de>, Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C rtc8564.c remove duplicate include (whitespace
 fixed)
Message-Id: <20050412001006.48736b86.khali@linux-fr.org>
In-Reply-To: <425A481A.7020801@anagramm.de>
References: <425125EC.6080201@anagramm.de>
	<20050409131643.4269911a.khali@linux-fr.org>
	<425A481A.7020801@anagramm.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clemens,

> [PATCH] I2C rtc8564.c remove duplicate include
> 
> Trivial fix: removes duplicate include line.
> Patch applies to: 2.6.11.x
> 
> (This is my very first patch to the linux-kernel, so let me
> start with small things first...)
> 
> Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>

Thanks for the patch, I added it to my stack. Greg, please pick it for
your i2c tree.

-- 
Jean Delvare
