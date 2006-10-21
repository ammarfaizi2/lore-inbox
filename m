Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992748AbWJUAYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992748AbWJUAYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992753AbWJUAYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:24:49 -0400
Received: from smtp.ono.com ([62.42.230.12]:52163 "EHLO resmaa05.ono.com")
	by vger.kernel.org with ESMTP id S2992748AbWJUAYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:24:48 -0400
Date: Sat, 21 Oct 2006 02:24:38 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061021022438.46e5904f@werewolf-wl>
In-Reply-To: <20061020015641.b4ed72e5.akpm@osdl.org>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.5.6cvs1 (GTK+ 2.10.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 01:56:41 -0700, Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> 

Stupid question: how can I build sunrpc as a module ?
My distro requires that, it tries to load it on initscripts to start
part of the nfs subsystem.

I have digged through menuconfig and gconfig and am not able to set SUNRPC=m,
it just gets autoselected y/n by other options.

TIA.

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.1 (Cooker) for i586
Linux 2.6.18-jam05 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #1 SMP PREEMPT
