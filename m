Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbULLLZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbULLLZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 06:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbULLLZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 06:25:39 -0500
Received: from mail1.kontent.de ([81.88.34.36]:33959 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262059AbULLLZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 06:25:35 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Marcin =?iso-8859-2?q?Gibu=B3a?= <mg@iceni.pl>
Subject: Re: STIr4200 warnings
Date: Sun, 12 Dec 2004 12:25:33 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200412121153.33981@senat>
In-Reply-To: <200412121153.33981@senat>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200412121225.34222.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Dezember 2004 11:53 schrieb Marcin Gibu³a:
> Hi,
> I've started playing with my SigmaTel STIr4200 IrDA bridge and my logs are 
> full of warnings (like the one below) just after I run irattach irda0 -s. 
> Kernel version is 2.6.10-rc3.
> 
> printk: 13 messages suppressed.
> usb_unlink_urb() is deprecated for synchronous unlinks.  Use usb_kill_urb() 
> instead.

The newest kernel does just that. Can you update and retest?

	Regards
		Oliver
