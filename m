Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUFNX5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUFNX5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 19:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFNX5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 19:57:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8835 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264540AbUFNX5I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 19:57:08 -0400
Message-ID: <40CE3B41.90407@pobox.com>
Date: Mon, 14 Jun 2004 19:56:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] kbuild
References: <20040614204029.GA15243@mars.ravnborg.org>
In-Reply-To: <20040614204029.GA15243@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> default kernel image:		Specify default target at config
> 				time rather then hardcode it.
> 				Only enabled for i386 for now.


> external module build doc:	Add documentation for building external modules


I like these two especially.  Thanks much,

	Jeff


