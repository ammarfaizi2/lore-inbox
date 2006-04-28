Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWD1HtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWD1HtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 03:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWD1HtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 03:49:24 -0400
Received: from ns2.hostinglmi.net ([213.194.149.12]:15842 "EHLO
	ns2.hostinglmi.net") by vger.kernel.org with ESMTP id S1030306AbWD1HtX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 03:49:23 -0400
Date: Fri, 28 Apr 2006 09:54:52 +0200
From: David =?utf-8?B?R8OzbWV6?= <david@pleyades.net>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: IP1000 gigabit nic driver
Message-ID: <20060428075452.GA18740@fargo>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20060427142939.GA31473@fargo> <20060427185627.GA30871@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20060427185627.GA30871@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns2.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pleyades.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francois,

On Apr 27 at 08:56:27, Francois Romieu wrote:
> /me goes to http://www.icplus.com.tw/driver-pp-IP1000A.html
> 
> $ unzip -c IP1000A-Linux-driver-v2.09f.zip | grep MODULE_LICENSE
>     MODULE_LICENSE("GPL");

Thanks, i didn't notice it ;-)

> It's a bit bloaty but it does not seem too bad (not mergeable "as
> is" though). Do you volunteer to test random cra^W^W carefully
> engineered code on your computer to help the rework/merging process ?

Yes, i am. Send me all the the cra ;-), i'm ready to
test it.

cheers,

-- 
David Gómez                                      Jabber ID: davidge@jabber.org
