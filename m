Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315190AbSD2UR4>; Mon, 29 Apr 2002 16:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSD2URz>; Mon, 29 Apr 2002 16:17:55 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:37609 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S315190AbSD2URz>; Mon, 29 Apr 2002 16:17:55 -0400
Message-Id: <200204292017.PAA25836@popmail.austin.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Hyperthreading and physical/logical CPU identification
Date: Mon, 29 Apr 2002 14:59:51 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7DF0@orsmsx111.jf.intel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I would very much like to believe that in this configuration,
> > I am only
> > running on 2 physical, 4 logical processors, but I am getting a 31%
> > improvement (netbench) when hyperthreading is enabled.  Thats
> > why I want to
> > confirm I am really only using 2 physical, 4 logical
> > processors.  Is there
> > any way I can do this? (dmesg? /proc/cpuinfo?)
>
> Well the two alternatives are, either A) turning on hyperthreading enabled
> the two virtual processors or B) turning on hyperthreading somehow enabled
> the other two processors, right?
>
> I would think B would be highly unlikely.
>
> Anyone else who actually has HT hardware care to comment? ;-)
>
> Regards -- Andy

Yes, those are the two alternatives.  I agree B is unlikely, but honestly I 
thought a 31% improvement from hyperthreading seemed unlikely as well.  
Believe me, I am hoping situaiton A is the correct one!

-Andrew

