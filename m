Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVA0R4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVA0R4o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVA0R4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:56:22 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:8652 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262682AbVA0Ryn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:54:43 -0500
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
	threading error
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org
In-Reply-To: <41F85CAB.40009@comcast.net>
References: <217740000.1106412985@[10.10.2.4]>	<41F30E0A.9000100@osdl.org>
	 <1106482954.1256.2.camel@tux.rsn.bth.se>
	 <20050126132504.3295e07d@dxpl.pdx.osdl.net>  <41F85CAB.40009@comcast.net>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 10:54:31 -0700
Message-Id: <1106848472.3397.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing crashes in FC4 rawhide with the 2.6.xx kernel in FC4 rawhide
as well. However, I only see  it if I start, and then try to save the
document (without or without changes).. i.e. saving a new document... I
may see this under saving as as well, but I rarely do that so I don't
know. (AMD Athlon here, not Athlon64)

That is the ONLY crash I see.

Trever

On Wed, 2005-01-26 at 22:14 -0500, Parag Warudkar wrote:
> Stephen Hemminger wrote:
> 
> >On my laptop with Fedora Core 3, OpenOffice 1.0.1, 1.0.4 and the pre 2.0 version
> >all work fine running 2.6.10-FCxx kernel but get a SEGV when running on 2.6.11-rc1 or 2.6.11-rc2
> >
> >Any hints?
> >  
> >
> Works fine here -  FC3-x86 on Athlon64 and 2.6.11-rc2 stock. Both  OO.o 
> 1.1.3 and latest M69 run fine.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
--
"The idea that Bill Gates has appeared like a knight in shining armour
to lead all customers out of a mire of technological chaos neatly
ignores the fact that it was he who, by peddling second-rate technology,
led them into it in the first place." -- Douglas Adams, on Windows '95.

