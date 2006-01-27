Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWA0QNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWA0QNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWA0QNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 11:13:54 -0500
Received: from [212.76.81.158] ([212.76.81.158]:4881 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751500AbWA0QNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 11:13:53 -0500
From: Al Boldi <a1426z@gawab.com>
To: Bryan Henderson <hbryan@us.ibm.com>
Subject: Re: [RFC] VM: I have a dream...
Date: Fri, 27 Jan 2006 19:12:59 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <OF9E36966D.F24577F5-ON88257102.0069A68A-88257102.006A185F@us.ibm.com>
In-Reply-To: <OF9E36966D.F24577F5-ON88257102.0069A68A-88257102.006A185F@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601271912.59557.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Henderson wrote:
> >[explanation of memory/disk split]
> >...
> >So we have a situation right now that imposes a legacy solution on
> >hardware that is really screaming (64+) to be taken advantage of.
>
> Put that way, you seem to be describing exactly single level storage as
> seen in an IBM Eserver I Series (fka AS/400, nee System/38).

To some extent.

> So we know it works, but also that people don't seem to care much for it

People didn't care, because the AS/400 was based on a proprietary solution.  
I remember a client being forced to dump an AS/400 due to astronomical 
maintenance costs.

With todays generically mass-produced 64bit archs, what's not to care about a 
cost-effective system that provides direct mapped access into linear address 
space?

Thanks!

--
Al

