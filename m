Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUHIHlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUHIHlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHIHlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 03:41:39 -0400
Received: from guardian.hermes.si ([193.77.5.150]:24847 "EHLO
	guardian.hermes.si") by vger.kernel.org with ESMTP id S266196AbUHIHlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 03:41:37 -0400
Message-ID: <B1ECE240295BB146BAF3A94E00F2DBFF09020F@piramida.hermes.si>
From: David Balazic <david.balazic@hermes.si>
To: David Balazic <david.balazic@hermes.si>,
       "'Pat LaVarre'" <p.lavarre@ieee.org>
Cc: "'David Burg'" <dburg@nero.com>, linux_udf@hpesjro.fc.hp.com,
       linux-kernel@vger.kernel.org
Subject: RE: Can not read UDF CD
Date: Mon, 9 Aug 2004 09:33:17 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> ----------
> From: 	Pat LaVarre[SMTP:p.lavarre@ieee.org]
> Sent: 	2. avgust 2004 16:42
> To: 	David Balazic
> Cc: 	'David Burg'; linux_udf@hpesjro.fc.hp.com;
> linux-kernel@vger.kernel.org
> Subject: 	Re: Can not read UDF CD
> 
> > How should I make the image ?
> > Remember, it is a multisession CD ( has two sessions ).
> 
> Sorry I'm not yet caught up on all the help volunteered in this thread.
> 
> Have you specifically confirmed you can make more than one of these 
> discs?  In the last resort, you could send the actual disc to my 
> mailing address.
> 
> Have you specifically confirmed certain forms of the session= option do 
> not work?
> 
I tried session=0.
This gives me the files form the first session, but I can only list them.
I can not see their attributes ( size, permissions etc.. ) or read them.
other session=x values fails to mount.

> Pat LaVarre
> 
