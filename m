Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSGINV6>; Tue, 9 Jul 2002 09:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSGINV5>; Tue, 9 Jul 2002 09:21:57 -0400
Received: from 62-190-201-5.pdu.pipex.net ([62.190.201.5]:59143 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S315218AbSGINV5>; Tue, 9 Jul 2002 09:21:57 -0400
From: jbradford@dial.pipex.com
Message-Id: <200207091329.OAA01868@darkstar.example.net>
Subject: Re: list of compiled in support
To: MMARTINEZ@intranet.reeusda.gov (Martinez, Michael - CSREES/ISTM)
Date: Tue, 9 Jul 2002 14:29:38 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <630DA58AD01AD311B13A00C00D00E9BC05D20216@CSREESSERVER> from "Martinez, Michael - CSREES/ISTM" at Jul 09, 2002 09:09:52 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can't you just

grep ipx System.map

???  Or am I being thick again?  :-/

> No, no. Just simply find out whether my kernel supports ipx. And if it does
> support it, then to disable it, without recompiling the kernel, perhaps by
> removing ipx entries from /etc/services.
> 
> Michael Martinez
> System Administrator (Contractor)
> Information Systems and Technology Management
> CSREES - United States Department of Agriculture
> (202) 720-6223
> 
> 
> -----Original Message-----
> From: Thunder from the hill [mailto:thunder@ngforever.de]
> Sent: Tuesday, July 09, 2002 8:53 AM
> To: Martinez, Michael - CSREES/ISTM
> Cc: 'Alan Cox'; linux-kernel@vger.kernel.org
> Subject: RE: list of compiled in support
> 
> 
> Hi,
> 
> On Tue, 9 Jul 2002, Martinez, Michael - CSREES/ISTM wrote:
> > Okay. this would require a little C code right? is there a shell command
> > line tool I could use instead?
> 
> What exactly is your intention? IPX networking from a shell script?
> 
> 							Regards,
> 							Thunder
> -- 
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y- 
> ------END GEEK CODE BLOCK------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

