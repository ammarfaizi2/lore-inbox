Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292848AbSB0Wq1>; Wed, 27 Feb 2002 17:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293029AbSB0Wp7>; Wed, 27 Feb 2002 17:45:59 -0500
Received: from mail.shorewall.net ([206.124.146.177]:38150 "EHLO
	mail.shorewall.net") by vger.kernel.org with ESMTP
	id <S293028AbSB0Wpa>; Wed, 27 Feb 2002 17:45:30 -0500
From: "Tom Eastep" <teastep@shorewall.net>
To: "'James Cassidy'" <jcassidy@cs.kent.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: VIA Northbridge Workaround in 2.4.18 Causing Video Problems
Date: Wed, 27 Feb 2002 14:45:31 -0800
Organization: Shoreline Firewall
Message-ID: <000e01c1bfe0$76103e00$0501a8c0@ursa>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
In-Reply-To: <20020227223301.GA632@qfire.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: James Cassidy [mailto:jcassidy@qfire.net] On Behalf Of 
> James Cassidy
> Sent: Wednesday, February 27, 2002 2:33 PM
> To: Tom Eastep
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: VIA Northbridge Workaround in 2.4.18 Causing 
> Video Problems
> 
> 
> 	Odd, I have had constant problems with crashes when 
> ever I stressed
> my memory system with Athlon kernel selected in the kernel 
> config. Same
> machine,  Compaq Presario 700 series.

Mine is not a 700 -- it is Presario 5108US Desktop.

> Usually a kernel 
> compile was enough
> to cause an opps on one of these kernels. 
> 	When the path in 2.4.18 in pre1 or pre2 don't remember, 
> it fixed the
> problem on my Compaq Presario 700. I've been running the 2.4.18 series
> since the patch was added and as of today I have not 
> experienced another
> opps of this kind with the Athlon option enabled in the kernel.
> 

Your system appears to be one of the ones for which the workaround is
effective. Mine on the other hand works fine without the workaround and
has problems when the workaround is activated.

-Tom
--
Tom Eastep   \ Shorewall -- iptables made easy
AIM: tmeastep \ http://www.shorewall.net
ICQ: #60745924 \ teastep@shorewall.net 

