Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTEAPft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 11:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbTEAPft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 11:35:49 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41624
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261411AbTEAPfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 11:35:48 -0400
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Backlund <tmb@iki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305011801.39014.tmb@iki.fi>
References: <3EB0413D.2050200@superonline.com> <b8r26l$he0$1@main.gmane.org>
	 <1051790876.21546.10.camel@dhcp22.swansea.linux.org.uk>
	 <200305011801.39014.tmb@iki.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051800568.21442.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 May 2003 15:49:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-01 at 16:01, Thomas Backlund wrote:
> You mean the patch that only looks at videomode, dont you...

I do

> Well maybe it's best to use it as default, to avoid this bug 
> "out of the box"...
> 
> But I will remake a patch to ovverride it so that the users who 
> need/want the extra memory to be able to allocate it...
> since I like the idea of giving the user the choice...

Sounds right to me


