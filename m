Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267315AbUHIV5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267315AbUHIV5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 17:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267307AbUHIV5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 17:57:02 -0400
Received: from mail.kroah.org ([69.55.234.183]:25570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267304AbUHIV4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 17:56:47 -0400
Date: Mon, 9 Aug 2004 14:55:53 -0700
From: Greg KH <greg@kroah.com>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: linux@brodo.de, linux-kernel@vger.kernel.org
Subject: Re: ASUS L3C SMBus fixup
Message-ID: <20040809215553.GA810@kroah.com>
References: <20040808214313.GA18097@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040808214313.GA18097@hell.org.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 11:43:13PM +0200, Karol Kozimor wrote:
> Hi,
> Following the notes on bug #2976, here's the patch to add ASUS L3C notebook
> to the list of machines hiding SMBus chip. The patch is against
> 2.6.8-rc3-mm1.

Applied to my trees, thanks.

greg k-h
