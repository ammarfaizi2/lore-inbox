Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313038AbSDJM67>; Wed, 10 Apr 2002 08:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313044AbSDJM66>; Wed, 10 Apr 2002 08:58:58 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:56072 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S313038AbSDJM65> convert rfc822-to-8bit; Wed, 10 Apr 2002 08:58:57 -0400
Subject: Re: how to balance interrupts between 2 CPUs?
From: Philippe Amelant <pamelant@linux-at-business.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <b5926afe75.afe75b5926@water.pku.edu.cn>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Apr 2002 14:54:54 +0200
Message-Id: <1018443294.6396.10.camel@avior>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 10/04/2002 à 14:23, zxj@water.pku.edu.cn a écrit :
> Hello
> 
>     I am using two Intel Giga NICs in a DELL PowerEdge 4600
>     with 2 Intel XEON 1.8GHz CPUs.
>     The matherboard is ServerWorks GC-HE.
>     The OS is RedHat 7.2, and the release of kernel is "2.4.7-10smp".
> 
>     The CPU0 has very heavy interrupt traffic,
>     you can see the following information:


Are you using "noapic" on boot ?

