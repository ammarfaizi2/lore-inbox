Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280907AbRKLSPj>; Mon, 12 Nov 2001 13:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKLSP3>; Mon, 12 Nov 2001 13:15:29 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:56846 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280815AbRKLSPO>;
	Mon, 12 Nov 2001 13:15:14 -0500
Date: Mon, 12 Nov 2001 11:14:25 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Gutschke <stephan@gutschke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011112111424.J25962@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE9BDD0.2070703@gutschke.com> <20011107151806.A22444@kroah.com> <3BEAD904.2050406@gutschke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BEAD904.2050406@gutschke.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 15 Oct 2001 17:52:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 08:12:04PM +0100, Stephan Gutschke wrote:
> 
> listen serial {
>                protocol: simple;
>                }

I just had a report of someone getting this to work by using 
"protocol: net"

Could you try that?

thanks,

greg k-h
