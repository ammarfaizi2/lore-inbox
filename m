Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269883AbRHJBd3>; Thu, 9 Aug 2001 21:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269884AbRHJBdT>; Thu, 9 Aug 2001 21:33:19 -0400
Received: from [209.202.108.240] ([209.202.108.240]:34055 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S269883AbRHJBdK>; Thu, 9 Aug 2001 21:33:10 -0400
Date: Thu, 9 Aug 2001 21:32:54 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: using bug reports on vendor kernels
In-Reply-To: <01080923020201.04501@idun>
Message-ID: <Pine.LNX.4.33.0108092129520.24229-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Aug 2001, Oliver Neukum wrote:

> Hi,
>
> is there a site that would allow me to browse a list of patches added to
> vendor kernels (esp. RedHat). I need this to use an oops supplied by a user.
>
> 	TIA
> 		Oliver

All of Red Hat's kernel SRPMs are available via FTP from ftp.redhat.com.
Basically they start with a stock kernel, add a decent -acXX, apply
vendor-specific drivers, and then any cleanups that exist or they wrote.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

