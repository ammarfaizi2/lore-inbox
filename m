Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267697AbUHPPYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267697AbUHPPYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 11:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUHPPQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 11:16:24 -0400
Received: from urs-smtp-01.nks.net ([24.73.112.33]:59153 "EHLO
	smtp102.urscorp.com") by vger.kernel.org with ESMTP id S267701AbUHPPLQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 11:11:16 -0400
In-Reply-To: <411D536A.7050206@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Horman <nhorman@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: [Patch} to fix oops in olympic token ring driver on media disconnect
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5 September 18, 2003
From: Mike_Phillips@URSCorp.com
Message-ID: <OF11E315D2.D4CBAED1-ON85256EF2.0052F29D-85256EF2.0053587E@urscorp.com>
Date: Mon, 16 Aug 2004 11:10:19 -0400
X-MIMETrack: Serialize by Router on SMTP102/URSCorp(Release 5.0.11  |July 24, 2002) at
 08/16/2004 11:11:54 AM,
	Serialize complete at 08/16/2004 11:11:54 AM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, regardless, Neil's patch is IMO a good first step.

Neil's patch is to make the annoying regression test failure go away. To 
be honest I have had *one* user email me that this is a problem and once I 
gave them the "don't remove the cable on token ring, its not ethernet" 
talk, they were fine. 

> There is plenty of work in olympic for any motivated person :)

It works, its used by an ever decreasing number of users - let it have a 
peaceful and graceful old age. 

Mike
