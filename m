Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265504AbTGCXFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265518AbTGCXFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 19:05:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44245 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265498AbTGCXFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 19:05:40 -0400
Message-ID: <3F04BA16.7050301@pobox.com>
Date: Thu, 03 Jul 2003 19:19:50 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Pryzby <justinpryzby@users.sf.net>
CC: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: "Will be removed in 2.4"
References: <20030703200134.GA18459@andromeda>
In-Reply-To: <20030703200134.GA18459@andromeda>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Pryzby wrote:
> Linux 2.4.21, include/asm/io.h:51 says "Will be removed in 2.4".  Its
> there in 2.5.74 as well.
> 
> I can understand why it would be in 2.5; the comment should say 2.6,
> though.


Actually there is a larger issue too:

I would love it if someone (kernel janitors?) went through the kernel 
code and dug out all the comments like this.  "should be gone by 1.3" :) 
  "should be removed in 2.5".  etc.  This should be a pretty easy, but 
time consuming job that even newbies could sink their teeth into.

Then we can go through the list and kill the issues, or the comments.

	Jeff



