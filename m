Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266917AbRHJLF2>; Fri, 10 Aug 2001 07:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266921AbRHJLFS>; Fri, 10 Aug 2001 07:05:18 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:5364 "EHLO
	tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S266917AbRHJLFK>; Fri, 10 Aug 2001 07:05:10 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: "Rainer Mager" <rvm@gol.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [somewhat OT] connecting to a box behind a NAT router
Date: Fri, 10 Aug 2001 06:04:04 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGIEICELAA.rvm@gol.com>
In-Reply-To: <NEBBJBCAFMMNIHGDLFKGIEICELAA.rvm@gol.com>
MIME-Version: 1.0
Message-Id: <01081006051600.19384@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Aug 2001, Rainer Mager wrote:
>Hi all,
>
>	I'm about to get ADSL installed for my home Internet connection and have
>chosen to do this via an ADSL router (as opposed to a modem). The router
>will have a static/global IP address but everything behind it will be
>connecting through the router via NAT. So, my question is, is there any way
>to get into (telnet or ssh) my box behind the router from outside?
>	Is there some sort of tunneling protocol/tool to do this? If so, what
>happens if I want to connect two boxes is the same situation (behind NAT
>routers)? Is is still possible? Is is interoperable with Windows and Linux?
>
>	Any ideas would be greatly appreciated.

It depends on the router. I use a Linux router and port forwarding to accomplish
that.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
