Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263273AbSJCNqW>; Thu, 3 Oct 2002 09:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSJCNqW>; Thu, 3 Oct 2002 09:46:22 -0400
Received: from babsi.intermeta.de ([212.34.181.3]:22801 "EHLO
	mail.intermeta.de") by vger.kernel.org with ESMTP
	id <S263273AbSJCNqV>; Thu, 3 Oct 2002 09:46:21 -0400
Subject: Re: Sequence of IP fragment packets on the wire
From: Henning Schmiedehausen <hps@intermeta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1033647370.28022.0.camel@irongate.swansea.linux.org.uk>
References: <anh7es$mpl$1@forge.intermeta.de> 
	<1033647370.28022.0.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 15:51:44 +0200
Message-Id: <1033653105.22055.2.camel@forge>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks to anyone for making this clear. Replacing this particular
system is currently out of question but I will take it on with the
people from SonicWall (oops, now the name did slip, silly me...)
to get this fixed ASAP. 

	Regards
		Henning


On Thu, 2002-10-03 at 14:16, Alan Cox wrote:
> On Thu, 2002-10-03 at 11:51, Henning P. Schmiedehausen wrote:
> > This confuses at least one firewall appliance. As I understand it,
> 
> You should replace that appliance. Packets can get re-ordered by a
> million different things on the wire not just by the fact Linux is
> optimising the fragment processes.
> 
> > Is there a way to configure this? Maybe even connection specific? 
> 
> No
> 
> Alan

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   

