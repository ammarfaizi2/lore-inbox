Return-Path: <linux-kernel-owner+w=401wt.eu-S1751322AbXAIKrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbXAIKrY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXAIKrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:47:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:12389 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbXAIKrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:47:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ofdgwRAJ7nJ6kXJzrm/RGysA8qD4oy8bTIThKv5CHjNHiEd67wTECo295BI4EJAM9AAFAVLalc1A2B9G5klo732zKkJNalEMZFDdzwvSNLpx/6U4ALzyJNV9lo5JsYtyWmg5/4Ngy12e5IqzWk9p6uBWHs/gyo9ZFztOX1iLDjM=
Message-ID: <6f61137b0701090247l6077cbb8k91eec388779c33cd@mail.gmail.com>
Date: Tue, 9 Jan 2007 11:47:21 +0100
From: "Maarten Vanraes" <maarten.vanraes@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AHCI IDENTIFY problem only on x86_64
Cc: "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <45A371E3.9090103@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>
	 <45A371E3.9090103@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i don't think so, but i cannot test it... i don't have an x86_64
system, and i cannot install on my disk, cause it's not detected.
unless i can install an x86_64 kernel on a i586 system, i donno how to
further test this.

2007/1/9, Jeff Garzik <jeff@garzik.org>:
> Maarten Vanraes wrote:
> > I would like to be CC'ed as i'm not on the list.
> >
> > kernel 2.16.17.13: in 32bit the disk is detected everything ok, in
> > x86_64, it gives a Failed to IDENTIFY for both drives, it does not
> > give a FAILED to IDENTIFY on the ones where the link is down.
> >
> > any idea what the problem is?
>
> May we presume that 2.6.20-rc4 works?
>
>         Jeff
>
>
>
>


-- 
Alien is my name and head-biting is my game
