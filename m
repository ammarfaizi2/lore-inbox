Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267622AbUBTAyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267641AbUBTAwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:52:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:36001 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267622AbUBTAv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:51:29 -0500
Date: Thu, 19 Feb 2004 16:20:47 -0800
From: Greg KH <greg@kroah.com>
To: Kianusch Sayah Karadji <kianusch@sk-tech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI-Scan Hangup ...
Message-ID: <20040220002047.GB16267@kroah.com>
References: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402191426360.27436@kryx.sk-tech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 02:35:59PM +0100, Kianusch Sayah Karadji wrote:
> Hi!
> 
> There I have a Soekris bord with some weird PCI Handup while booting
> Linux during PCI-Scan .

Can you try to determine what is hanging in a non-modified 2.6.3 kernel?

thanks,

greg k-h
