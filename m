Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTLRAz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 19:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264886AbTLRAz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 19:55:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:57760 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264884AbTLRAz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 19:55:58 -0500
Date: Wed, 17 Dec 2003 16:36:11 -0800
From: Greg KH <greg@kroah.com>
To: Daniel Stekloff <dsteklof@us.ibm.com>
Cc: azarah@gentoo.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: scsi_id segfault with udev-009
Message-ID: <20031218003611.GK6258@kroah.com>
References: <1071682198.5067.17.camel@nosferatu.lan> <200312171017.28358.dsteklof@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312171017.28358.dsteklof@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 10:17:28AM -0800, Daniel Stekloff wrote:
> 
> Please try this quick fix:

I've applied this, thanks.

greg k-h
