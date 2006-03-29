Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWC2K4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWC2K4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 05:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWC2K4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 05:56:23 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35850 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750888AbWC2K4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 05:56:22 -0500
Date: Wed, 29 Mar 2006 12:56:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: shiva g <shiva@isofttech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mark_bh in Linux 2.6.12 kernel
Message-ID: <20060329105600.GA13383@mars.ravnborg.org>
References: <010801c6531d$8283a3a0$7b01a8c0@shiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010801c6531d$8283a3a0$7b01a8c0@shiva>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 04:12:43PM +0530, shiva g wrote:
> Hi all,
>    We are porting a usb host controller driver from 2.4.18 kernel to 2.6.12 
> kernel. We face some issues with
> mark_bh( ) call. Can anyone suggest us how we proceed in porting mark_bh( ) 
> in the 2.6.12 kernel.
Posting the source may give you more/better feedback...

	Sam
