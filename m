Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265444AbUAIEmF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 23:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265506AbUAIEmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 23:42:05 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:54415 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265444AbUAIEmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 23:42:03 -0500
Message-ID: <3FFE3157.9030307@osdl.org>
Date: Thu, 08 Jan 2004 20:43:03 -0800
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Graham <lkthomas@sml.dyndns.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, bridge@osdl.org
Subject: Re: Bridge-utils update for 2.6 ?
References: <1059.192.168.0.97.1073611363.squirrel@sml.dyndns.org>
In-Reply-To: <1059.192.168.0.97.1073611363.squirrel@sml.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Graham wrote:

> does anyone know if there have any new update patch for Bridge-utils on
> 2.6.0kernel ?!
> http://bridge.sourceforge.net/download.html <--- this is the web site

Existing 2.4 kernels work on 2.6, no API changes.
I am planning on an update later when STP is moved out of the kernel.

