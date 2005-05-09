Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVEIPlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVEIPlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEIPlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:41:03 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27640 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S261429AbVEIPlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:41:00 -0400
Date: Mon, 9 May 2005 08:40:54 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH 2/4] rt_mutex: add new plist implementation
In-Reply-To: <427F763B.FEF0EA91@tv-sign.ru>
Message-ID: <Pine.LNX.4.44.0505090840010.14167-100000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 May 2005, Oleg Nesterov wrote:

> This patch adds new plist implementation, see
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111547290706136
> 
> Changes:
> 
> 	added plist_next_entry() helper (was plist_entry)
> 
> 	added plist_unhashed() helper, see PATCH 4/4
> 


	Naw , stick with Inaky's API .. Your stuff looks nothing like 
list.h ..

Daniel

