Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbVKDOpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbVKDOpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 09:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVKDOpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 09:45:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43952 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751450AbVKDOpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 09:45:01 -0500
Subject: Re: 2.6.14-rc5-mm1 - ide-cs broken!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, damir.perisa@solnet.ch, akpm@osdl.org
In-Reply-To: <20051104071932.GA6362@kroah.com>
References: <20051103220305.77620d8f.akpm@osdl.org>
	 <20051104071932.GA6362@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Nov 2005 15:14:53 +0000
Message-Id: <1131117293.26925.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 23:19 -0800, Greg KH wrote:
> Hint, gentoo, debian, and suse don't have this problem, so you might
> want to look at their rules files for how to work around this.  Look for
> this line:
> 
> # skip accessing removable ide devices, cause the ide drivers are horrible broken


I was under the impression people had eventually decided the media
change patch someone was proposed was ok after investigating one or two
cases I knew of that turned out to be borked hardware ?

