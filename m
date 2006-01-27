Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWA0TRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWA0TRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 14:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWA0TRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 14:17:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:50841 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932378AbWA0TRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 14:17:12 -0500
In-Reply-To: <200601271912.59557.a1426z@gawab.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 27 Jan 2006 11:17:04 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/27/2006 14:17:09,
	Serialize complete at 01/27/2006 14:17:09
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> So we know it [single level storage] works, but also that people don't 
seem to care much for it
>
>People didn't care, because the AS/400 was based on a proprietary 
solution. 

I don't know what a "proprietary solution" is, but what we had was a 
complete demonstration of the value of single level storage, in commercial 
use and everything,  and other computer makers (and other business units 
of IBM) stuck with their memory/disk split personality.  For 25 years, 
lots of computer makers developed lots of new computer architectures and 
they all (practically speaking) had the memory/disk split.  There has to 
be a lesson in that.

>With todays generically mass-produced 64bit archs, what's not to care 
about a 
>cost-effective system that provides direct mapped access into linear 
address 
>space?

I don't know; I'm sure it's complicated.  But unless the stumbling block 
since 1980 has been that it was too hard to get/make a CPU with a 64 bit 
address space, I don't see what's different today.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems

