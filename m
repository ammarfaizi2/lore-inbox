Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTFBDoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 23:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTFBDoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 23:44:10 -0400
Received: from granite.he.net ([216.218.226.66]:50437 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261798AbTFBDoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 23:44:10 -0400
Date: Sun, 1 Jun 2003 20:49:47 -0700
From: Greg KH <greg@kroah.com>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.70] - APIC error on CPU0: 00(40)
Message-ID: <20030602034946.GA27338@kroah.com>
References: <006c01c32755$4baabd10$2101a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <006c01c32755$4baabd10$2101a8c0@witbe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 11:16:18AM +0200, Paul Rolland wrote:
> 
> I also have a very strange :
> USB scanner device (0x03f0/0x2005) now attached to ^ER^VÀ\2003?ß\200 ?ß\2003?ß<7OÀØ6OÀÀ6OÀ
> 
> though I had :
> USB scanner device (0x03f0/0x2005) now attached to usb/scanner0
> with a 2.5.69

Should be fixed with the latest -bk version.
If not, please let me know.

thanks,

greg k-h
