Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291166AbSAaRUu>; Thu, 31 Jan 2002 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291165AbSAaRUm>; Thu, 31 Jan 2002 12:20:42 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:59079 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S291163AbSAaRUC>;
	Thu, 31 Jan 2002 12:20:02 -0500
Date: Thu, 31 Jan 2002 18:23:25 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-Id: <20020131182325.60443ed8.sebastian.droege@gmx.de>
In-Reply-To: <20020131194401.A818@namesys.com>
In-Reply-To: <20020130173715.B2179@namesys.com>
	<20020130163951.13daca94.sebastian.droege@gmx.de>
	<20020130190905.A820@namesys.com>
	<20020130174011.L24012@suse.de>
	<20020130201054.6e150f78.sebastian.droege@gmx.de>
	<20020130201757.Q24012@suse.de>
	<20020131122424.A874@namesys.com>
	<20020131134931.A5948@suse.de>
	<20020131155325.A3629@namesys.com>
	<20020131141101.B5948@suse.de>
	<20020131194401.A818@namesys.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 19:44:01 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Thu, Jan 31, 2002 at 02:11:01PM +0100, Dave Jones wrote:
> 
>    Ok, I think we got it. And yes it it was reiserfs fault.
>    What I really cannot understand is how it was working before???
> 
>    Ok, so anybody who sees the oopses should try 2 patches attached.
>    prealloc_init_list_head.diff is just forgotten initialisation
>    and pick_correct_key_version.diff is the real fix.
> 
>    I wonder is anybody will be able to reproduce a bug with these 2 fixes
>    (I hope not).
Hi,
everything seems to work perfect :)
my system has booted without any problems
Thanks and Bye
