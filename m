Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264849AbSKEN3p>; Tue, 5 Nov 2002 08:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSKEN3p>; Tue, 5 Nov 2002 08:29:45 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:2709 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264849AbSKEN3o>; Tue, 5 Nov 2002 08:29:44 -0500
Subject: Re: 2.5.46 won't compile with pcmcia_aha152x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: dave@AFRInc.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211050813050.12822-100000@puppy.afrinc.com>
References: <Pine.LNX.4.44.0211050813050.12822-100000@puppy.afrinc.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 13:58:26 +0000
Message-Id: <1036504706.4827.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 13:24, David G Hamblen wrote:
> 
> The last time I tried (2.5.29), this stuff worked. The next time I tried
> (2.5.39) it failed.  Here's the error with 2.5.46:
> 

Someone broke all the makefiles and as yet hasn't fixed this. There is a
hackish fix for it in the -ac tree

