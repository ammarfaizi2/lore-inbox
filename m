Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWETH0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWETH0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 03:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWETH0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 03:26:21 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:62726 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751271AbWETH0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 03:26:21 -0400
Date: Sat, 20 May 2006 09:26:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Kbuild] Proper syntax for initramfs dependencies
Message-ID: <20060520072606.GA9828@mars.ravnborg.org>
References: <446E9C8F.60905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446E9C8F.60905@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 09:35:27PM -0700, H. Peter Anvin wrote:
> This patch adjusts the generation of initramfs dependencies, so that the 
> syntax stays correct when there are multiple files.
This is already fixed in -linus.

	Sam
