Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSJQJxr>; Thu, 17 Oct 2002 05:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbSJQJxr>; Thu, 17 Oct 2002 05:53:47 -0400
Received: from mailgate.imerge.co.uk ([195.217.208.100]:46830 "EHLO
	imgserv04.imerge-bh.co.uk") by vger.kernel.org with ESMTP
	id <S261299AbSJQJxq>; Thu, 17 Oct 2002 05:53:46 -0400
Message-ID: <C0D45ABB3F45D5118BBC00508BC292DB9D4266@imgserv04>
From: James Finnie <jf1@IMERGE.co.uk>
To: "'ebiederm@xmission.com'" <ebiederm@xmission.com>,
       James Finnie <jf1@IMERGE.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andre@linux-ide.org'" <andre@linux-ide.org>
Subject: RE: [PATCH]:  Sanity checking for drives that claim to be LBA-48,
	 but aren't!
Date: Thu, 17 Oct 2002 11:02:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> There are also a set of bits that reports which revs of the 
> ATA standard
> a drive complies with.  Should we check that one as well?  
> 
> Eric
>  

Knowing my luck, those bits are probably broken on my drives too :)

Sounds like common sense though.  I don't pretend to know enough about how
the IDE driver works in order fix it... Andre? :) 


James


Oh, appologies to everyone for the line-wrapped patch, M$Exchange has *LOTS*
to answer for.  If you want the patch without line-wraps, email me and I'll
send it as an attachment.  Didn't want to polute the list.
 


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
Imerge Limited                          Tel :- +44 (0)1954 783600 
Unit 6 Bar Hill Business Park           Fax :- +44 (0)1954 783601 
Saxon Way                               Web :- http://www.imerge.co.uk 
Bar Hill 
Cambridge 
CB3 8SL 
United Kingdom 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


