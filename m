Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWBMUaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWBMUaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 15:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWBMUaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 15:30:55 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:20397
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964847AbWBMUay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 15:30:54 -0500
Subject: Re: Linux 2.6.16-rc3
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060212190520.244fcaec.akpm@osdl.org>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060212190520.244fcaec.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 14:30:48 -0600
Message-Id: <1139862648.3868.3.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-12 at 19:05 -0800, Andrew Morton wrote:

> - A couple of random tty-related oopses reported by Jesper Juhl.  We
>   don't know why these happened - they appear to not be related to the tty
>   buffering changes.

I just posted a patch for this under
[PATCH] tty reference count fix

This is not related to the tty buffering changes.

-- 
Paul Fulghum
Microgate Systems, Ltd

