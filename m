Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTBVQc7>; Sat, 22 Feb 2003 11:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266771AbTBVQc6>; Sat, 22 Feb 2003 11:32:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15234
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266367AbTBVQc6>; Sat, 22 Feb 2003 11:32:58 -0500
Subject: Re: Box freezes if I enable "AMD 76x native power management"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oleg Drokin <green@namesys.com>
Cc: thetech@folkwolf.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030222163057.A884@namesys.com>
References: <20030222163057.A884@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045935866.4723.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 17:44:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 13:30, Oleg Drokin wrote:
> Hello!
> 
>    Starting from 2.4.20 until now (including 2.4.21-pre4 and 2.4.21-pre4-ac5",
>    whenever I enable "AMD 76x native power management" in my kernel config, I get
>    kernel that hangs at boot after reporting elevator stuff about my IDE drives.
>    Is anybody interested?
> 

It doesnt work with some tyan boards. I've never found out why. Most of them you
load the module, it stops, you poke the button and it wakes up again and then works


