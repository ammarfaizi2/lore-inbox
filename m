Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277264AbRJIXIQ>; Tue, 9 Oct 2001 19:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278054AbRJIXIG>; Tue, 9 Oct 2001 19:08:06 -0400
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:65476
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S277264AbRJIXHu>; Tue, 9 Oct 2001 19:07:50 -0400
Date: Tue, 9 Oct 2001 16:05:30 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
In-Reply-To: <Pine.LNX.4.33.0110100059590.24292-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33.0110091604250.15092-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Oct 2001, Luigi Genoni wrote:

> and what is the content of
> /proc/net/ip_conntrack
> file?
>
> how big is the buffer you are using for packet tracing?
> (/proc/sys/net/ipv4/ip_conntrack_max)

Well, I'm not going to send that file to the Internet at large, but
ip_conntrack current has about 2100 lines and the max is 65535.

-jwb

