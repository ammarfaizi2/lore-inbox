Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293380AbSCUFTC>; Thu, 21 Mar 2002 00:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293379AbSCUFSw>; Thu, 21 Mar 2002 00:18:52 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:38643
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293380AbSCUFSl>; Thu, 21 Mar 2002 00:18:41 -0500
Date: Wed, 20 Mar 2002 21:20:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Bergs <flygong@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The network performance of linux
Message-ID: <20020321052008.GA2871@matchmail.com>
Mail-Followup-To: Bergs <flygong@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020321051219.9811.qmail@web14510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 09:12:19PM -0800, Bergs wrote:
> 
>  I work on a linux 2.2.14 kernel to test the network
> throughput of a linux  box used as a firewall.
> 
>  I find that when the IP packet length is 512B,the
> throughput is the highest 71%. IP packet length is
> smaller than 512B or bigger than 512B,the throughput
> is the lower.
> 
>    I don't know why this ? Can I have some solutions
> to improve the throughput of linux box ?
> 
> 

You'll need to post much more info about your hardware.

start with lspci and /proc/cpuinfo...

Also you didn't say how fast each packet size actually was, and did you use
a switch or what other type of network hardware.

Mike
