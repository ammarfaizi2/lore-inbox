Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUAMNmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 08:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUAMNmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 08:42:40 -0500
Received: from [81.171.138.7] ([81.171.138.7]:56526 "EHLO
	gateway.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id S264113AbUAMNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 08:42:38 -0500
Message-ID: <0EBC45FCABFC95428EBFC3A51B368C9501C9C436@jessica.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Date: Tue, 13 Jan 2004 13:42:24 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
X-herefordshire.gov.uk-MailScanner-Information: Please contact the ISP for more information
X-herefordshire.gov.uk-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Change all occurences of flavour to flavor
> 
> s/r/rr/
> 
> > I've just comiled all affected files
> 
> ...
> 
> > Andries, I did a small check if mount uses the fieldnames 
> frrom the kernel
> > headers, which doesn't seem to be the case, can you confirm 
> that this?
> 
> The theory still is that user space must not include kernel headers,
> so even if mount used some include this is not an objection.
> 
> On the other hand, I am not quite sure why one would do this.
> Fixing typos I like - occurences should be occurrences and 
> comiled compiled -
> but fixing something that is correct in English because it is 
> wrong in American?
> There are occasional words in Polish, Danish, French, German 
> in the kernel.
> I wouldn't mind some words in English.
> 
> Andries

I'd hazard a guess that number of non-American English speakers far
outnumbers the Americans, so can we stick to the Queen's English please?

Cheers,

Phil
---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK
