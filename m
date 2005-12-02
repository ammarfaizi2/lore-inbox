Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVLBUAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVLBUAF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 15:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVLBUAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 15:00:05 -0500
Received: from netcore.fi ([193.94.160.1]:24975 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S1751003AbVLBUAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 15:00:01 -0500
Date: Fri, 2 Dec 2005 21:59:46 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: Al Boldi <a1426z@gawab.com>
cc: netdev@vger.kernel.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] ip / ifconfig redesign
In-Reply-To: <200512022253.19029.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.64.0512022159060.14136@netcore.fi>
References: <200512022253.19029.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Al Boldi wrote:
> Consider this new approach for better address management:
> 1. Allow the definition of an address pool
> 2. Relate links to addresses
> 3. Implement to make things backward-compatible.
>
> The obvious benefit here, would be the transparent ability for apps to bind
> to addresses, regardless of the link existence.

That's called 'the loopback address', right? :)

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings
