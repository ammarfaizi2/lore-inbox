Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263210AbUDPXaW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 19:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUDPXaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 19:30:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40072 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263210AbUDPXaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 19:30:21 -0400
Date: Sat, 17 Apr 2004 00:30:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix typo in the openpromfs remount patch
Message-ID: <20040416233020.GJ24997@parcelfarce.linux.theplanet.co.uk>
References: <1082157219.2985.41.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082157219.2985.41.camel@pegasus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 01:13:39AM +0200, Marcel Holtmann wrote:
> Hi Linus,
> 
> the openpromfs remount patch which was merged some minutes ago contains
> a silly typo in the field of the super_operations structure.

Thanks for spotting (and guess which filesystem is platform dependent ;-/)
