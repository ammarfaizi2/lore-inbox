Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWAZTSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWAZTSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWAZTSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:18:54 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51840 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964842AbWAZTSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:18:52 -0500
In-Reply-To: <200601260104.57984.a1426z@gawab.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF9E36966D.F24577F5-ON88257102.0069A68A-88257102.006A185F@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 26 Jan 2006 11:18:50 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/26/2006 14:18:50,
	Serialize complete at 01/26/2006 14:18:50
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[explanation of memory/disk split]
>...
>So we have a situation right now that imposes a legacy solution on 
hardware 
>that is really screaming (64+) to be taken advantage of.

Put that way, you seem to be describing exactly single level storage as 
seen in an IBM Eserver I Series (fka AS/400, nee System/38).

So we know it works, but also that people don't seem to care much for it 
(because in 35 years, it hasn't taken over the world - we got to today's 
machines with 64 bit address spaces for other reasons).

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems


