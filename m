Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRFRQYW>; Mon, 18 Jun 2001 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261390AbRFRQYM>; Mon, 18 Jun 2001 12:24:12 -0400
Received: from CM-46-30.chello.cl ([24.152.46.30]:22918 "EHLO
	CM-46-30.chello.cl") by vger.kernel.org with ESMTP
	id <S261385AbRFRQX4>; Mon, 18 Jun 2001 12:23:56 -0400
Date: Mon, 18 Jun 2001 12:20:23 -0400 (CLT)
From: Fabian Arias <dewback@vtr.net>
To: Ted Gervais <ve1drg@ve1drg.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ipchains
In-Reply-To: <Pine.LNX.4.21.0106181256120.2050-100000@ve1drg.com>
Message-ID: <Pine.LNX.4.21.0106181218210.1107-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ronto:~# uname -r
2.4.5-ac15
ronto:~# ipchains --version
ipchains 1.3.10, 1-Sep-2000
ronto:~# ipchains -L
Chain input (policy ACCEPT):
target     prot opt     source                destination           ports
DENY       all  ----l-  pD951B780.dip.t-dialin.net anywhere
n/a
DENY       all  ----l-  CM-46-30.chello.cl   anywhere              n/a
DENY       all  ----l-  199.103.178.1        anywhere              n/a
......

Are you shure you get it right into the kernel?.

On Mon, 18 Jun 2001, Ted Gervais wrote:

> I just ran into something odd. To me anyways, it was odd.
> I just installed and brought up kernel 2.4.5 and my ipchains failed.
> So I upgraded to the latest (that I could find) ipchains-1.3.10, and
> that also fails.
> 
> Has anyone got any version of ipchains to work with the new(er) kernels?
> 
> ---
> Doubt is not a pleasant condition, but certainty is absurd.
>                 -- Voltaire
>                 
> Ted Gervais <ve1drg@ve1drg.com>
> 44.135.34.201 linux.ve1drg.ampr.org
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

 ---
 Fabian Arias Mu~oz                     |    		  Debian GNU/Linux Sid
 Facultad de Cs. Economicas y           |      	   Kernel 2.4.5ac15 - ReiserFS
 Administrativas.                       |                     "aka" dewback en
 Universidad de Concepcion   -  Chile   |                 #linuxhelp IRC.CHILE

