Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261336AbREUMgF>; Mon, 21 May 2001 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbREUMfp>; Mon, 21 May 2001 08:35:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61199 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261366AbREUMfk>; Mon, 21 May 2001 08:35:40 -0400
Subject: Re: Background to the argument about CML2 design philosophy
To: dwmw2@infradead.org (David Woodhouse)
Date: Mon, 21 May 2001 13:31:10 +0100 (BST)
Cc: chromi@cyberspace.org (Jonathan Morton),
        helgehaf@idb.hist.no (Helge Hafting), esr@thyrsus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <18583.990447323@redhat.com> from "David Woodhouse" at May 21, 2001 01:15:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E151oq6-0003iB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2) Have a HACKERS submenu system which contains all the derivations
> > that could *possibly* be un-defaulted, and allow our intrepid hacker
> > to explicitly force each to a value or leave unset.
> 
> I prefer the former, which is how it's already implemented in CML1.

Its called Debugging in CML1 in -ac for a reason btw. Because its called 
debugging I get plenty of reports that start

"I dont know much about this but I turned on all the debugging options and now
 instead of hanging it says Oops 0xA5A5A5A5 ..."

which are a lot more useful. 

Names matter a lot 


