Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbTAIKcS>; Thu, 9 Jan 2003 05:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbTAIKcS>; Thu, 9 Jan 2003 05:32:18 -0500
Received: from home.wiggy.net ([213.84.101.140]:17051 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S262528AbTAIKcR>;
	Thu, 9 Jan 2003 05:32:17 -0500
Date: Thu, 9 Jan 2003 11:40:57 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: ipv6 stack seems to forget to send ACKs
Message-ID: <20030109104057.GM22951@wiggy.net>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <20030108224339.GO22951@wiggy.net> <Pine.LNX.4.44.0301091131370.29527-100000@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301091131370.29527-100000@dns.toxicfilms.tv>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Maciej Soltysiak wrote:
> What other linux clients support streaming on ip6 ? patched mpg123 maybe?

The xmms patch can be adopted to work for mpg123 I suspect, I haven't
tried that.

> What XP client are you using ?

Iirc mediaplayer was used.

> Maybe it is a client issue, you say the client stops sending ACKs, maybe
> the client code is buggy.

I don't think a userspace tool can cause ACKs to stop being send.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
