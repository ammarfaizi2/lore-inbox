Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVEETfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVEETfc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVEETes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:34:48 -0400
Received: from mail.dvmed.net ([216.237.124.58]:901 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262178AbVEETEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:04:38 -0400
Message-ID: <427A6E3F.5090904@pobox.com>
Date: Thu, 05 May 2005 15:04:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial v0.4d
References: <20050504025852.GK22038@waste.org> <20050504181802.GS22038@waste.org>
In-Reply-To: <20050504181802.GS22038@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> The web protocol is painfully slow, mostly because it makes an http
> round trip per file revision to pull. I'm about to start working on a
> replacement that minimizes round trips.

Can you make it do HTTP 1.1 pipelining?

	Jeff


