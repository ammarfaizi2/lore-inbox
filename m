Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265862AbRFYD23>; Sun, 24 Jun 2001 23:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbRFYD2U>; Sun, 24 Jun 2001 23:28:20 -0400
Received: from [202.108.8.204] ([202.108.8.204]:9992 "HELO linux.tcpip.cxm")
	by vger.kernel.org with SMTP id <S265862AbRFYD2G>;
	Sun, 24 Jun 2001 23:28:06 -0400
Date: Mon, 25 Jun 2001 11:27:56 +0800
From: hugang <linuxbest@soul.com.cn>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RPC vs Socket
Message-Id: <20010625112756.25c7b81c.linuxbest@soul.com.cn>
In-Reply-To: <shs66dnryb0.fsf@charged.uio.no>
In-Reply-To: <20010621052321.24581.qmail@nw171.netaddress.usa.net>
	<20010623160658.A19533@artax.karlin.mff.cuni.cz>
	<shs66dnryb0.fsf@charged.uio.no>
Organization: soul
X-Mailer: Sylpheed version 0.4.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2001 17:49:39 +0200
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
	
> >>>>> " " == Jan Hudec <bulb@ucw.cz> writes:
> 
>      > Both seem to have pros and cons. RPC should be easier to write
>      > (especialy the server side), but it performs bad with UDP on
>      > slow links. (NFS did not work on 115200 serial line because of
>      > too many dropped packets - TCP flow control too badly needed in
>      > such cases). Or can linux do RPC over TCP?
> 
> The RPC client code for TCP is ready and already working both in
> 2.2.18+ and 2.4.x.
> 
> The server code however needs work.

Where can find some document for write rpc program in kernel .

Thanks
