Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293673AbSCPC1C>; Fri, 15 Mar 2002 21:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293675AbSCPC0m>; Fri, 15 Mar 2002 21:26:42 -0500
Received: from codepoet.org ([166.70.14.212]:30114 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S293673AbSCPC0i>;
	Fri, 15 Mar 2002 21:26:38 -0500
Date: Fri, 15 Mar 2002 19:26:41 -0700
From: Erik Andersen <andersen@codepoet.org>
To: john slee <indigoid@higherplane.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
Message-ID: <20020316022640.GA14642@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	john slee <indigoid@higherplane.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0203111436120.14945-100000@weyl.math.psu.edu> <E16kW0A-0001Yl-00@the-village.bc.nu> <20020313125507.C38@toy.ucw.cz> <20020315174916.GE27706@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315174916.GE27706@higherplane.net>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Mar 16, 2002 at 04:49:17AM +1100, john slee wrote:
> i believe the next debian (after the one currently stabilizing for
> release) has "real" use of capabilities as a major goal although that
> was hearsay and may be entirely false.  the amount of work involved is
> not insignificant

I expect that teaching start-stop-daemon about capabilities would
take care of much of the needed work automagically.  But this is
rapidly wandering off topic.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
