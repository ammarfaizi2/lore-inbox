Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRJZLfn>; Fri, 26 Oct 2001 07:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278410AbRJZLfd>; Fri, 26 Oct 2001 07:35:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7952 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S278403AbRJZLfR>; Fri, 26 Oct 2001 07:35:17 -0400
Message-ID: <3BD94A65.1A8E6B84@idb.hist.no>
Date: Fri, 26 Oct 2001 13:35:02 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <E15wjqP-0004kD-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 
> > But if I say "suspend", and the kernel refuses, I will kill the offending
> > piece of crap from sg.c before you can blink an eye.
> 
> Thats fine by me. Anyone wanting to be able to burn cds safely can run a
> -ac kernel tree

Telling the kernel to suspend while burning a CD is
on the same level as ejecting the CD while burning.  
It has to go wrong.  Someone explicitly asking for
trouble might as well get it.

The really dumb users is probably using a GUI tool
for either activity, that one may of course refuse
to ruin the burn.

Helge Hafting
