Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267444AbTAHNXz>; Wed, 8 Jan 2003 08:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAHNXz>; Wed, 8 Jan 2003 08:23:55 -0500
Received: from home.wiggy.net ([213.84.101.140]:14305 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S267444AbTAHNXx>;
	Wed, 8 Jan 2003 08:23:53 -0500
Date: Wed, 8 Jan 2003 14:30:24 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030108133024.GT22951@wiggy.net>
Mail-Followup-To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030108130850.GQ22951@wiggy.net> <Pine.LNX.4.44.0301081425490.8230-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301081425490.8230-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Maciej Soltysiak wrote:
> Which ipv6 client should i be using ?

I am using a patched version of xmms using the patch from
http://bugs.debian.org/155955 . (Don't forget to rerun autoconf
after applying the patch). If you want I can create an ipv6
enabled xmms.deb for you if you are using Debian.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
