Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268243AbUHFTTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268243AbUHFTTq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHFTTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:19:46 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:17677 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S268243AbUHFTTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:19:39 -0400
Message-ID: <4113D977.9040105@lougher.demon.co.uk>
Date: Fri, 06 Aug 2004 20:18:15 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <41127371.1000603@lougher.demon.co.uk> <4112D6FD.4030707@yahoo.com.au> <4112EAAB.8040005@yahoo.com.au> <4113B8A2.4050609@lougher.demon.co.uk> <4113D4CD.5080109@yahoo.com.au>
In-Reply-To: <4113D4CD.5080109@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> No, I suggest you start to code assuming this interface does
> what it does. I didn't say there is no bug here, but nobody
> else's filesystem breaks.
> 

To stop this silly argument from escalating, I will patch my code.

Phillip


