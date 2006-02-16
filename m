Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWBPV7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWBPV7i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWBPV7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:59:38 -0500
Received: from cantor.suse.de ([195.135.220.2]:26005 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932561AbWBPV7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:59:37 -0500
From: Andi Kleen <ak@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Wrong number of core_siblings in sysfs for Athlon64 X2
Date: Thu, 16 Feb 2006 22:59:32 +0100
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>
References: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com>
In-Reply-To: <9a8748490602161346x6e2802e8r4edf7dcbdafa5e17@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602162259.32433.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 February 2006 22:46, Jesper Juhl wrote:

> Obviously something is wrong, but I just can't seem to spot it.  Any clues?

It's a bitmap. 3 = 0b11 

-Andi


