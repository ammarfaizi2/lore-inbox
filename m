Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVESQUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVESQUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 12:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVESQUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 12:20:39 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:17872 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261168AbVESQUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 12:20:03 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "linux" <kernel@wired-net.gr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4 kernel threads
Date: Thu, 19 May 2005 09:19:55 -0700
User-Agent: KMail/1.8
References: <20050518223303.GE1340@ca-server1.us.oracle.com> <20050519094517.GD5112@stusta.de> <00e301c55c5c$eb83d7c0$0101010a@dioxide>
In-Reply-To: <00e301c55c5c$eb83d7c0$0101010a@dioxide>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505190919.55774.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, May 19, 2005 3:24 am, you wrote:
> While attempting to unload the kernel module which has created a
> kernel thread whoch runs perfectly i get this oops:
> Unable to handle kernel paging request at virtual address d08f364c

Your messages keep showing up as replies to other threads.  It looks 
like you're just hitting 'reply' to the latest message in your lkml 
mailbox in order to post a new message (at least the headers of your 
mail contain references to unrelated messages).  Please don't do this.  
Just create a new message with 'linux-kernel@vger.kernel.org' in the To 
field.  People will be more likely to see your message this way since 
it won't be buried in a thread they may or may not be interested in.

Thanks,
Jesse
