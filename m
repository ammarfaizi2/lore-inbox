Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293721AbSCPF4J>; Sat, 16 Mar 2002 00:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293720AbSCPF4A>; Sat, 16 Mar 2002 00:56:00 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:43782 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293725AbSCPFzp>;
	Sat, 16 Mar 2002 00:55:45 -0500
Date: Fri, 15 Mar 2002 21:55:42 -0800
From: Greg KH <greg@kroah.com>
To: Gordon J Lee <gordonl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020316055542.GA8125@kroah.com>
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com> <3C92B1EA.F40BDBD5@world.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C92B1EA.F40BDBD5@world.std.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 16 Feb 2002 03:54:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 09:46:02PM -0500, Gordon J Lee wrote:
> > > 2.4.9     works fine!
> >
> > Forgot to mention, how many processors does this kernel show you having?
> 
> It has two physical packages, and shows two processors.  See below.

Ah, can you try the latest 2.4.19-ac tree and make sure that the rest of
your processors (the "evil" twins) show up?

thanks,

greg k-h
