Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbWBAHAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWBAHAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 02:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbWBAHAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 02:00:30 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:36636 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030557AbWBAHA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 02:00:29 -0500
In-Reply-To: <20051221115009.GZ6703@pengutronix.de>
References: <a59861030512210307l4c8a0a29o@mail.gmail.com> <20051221115009.GZ6703@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3405AA51-AE3C-4E8F-AFA5-88B103B1E02C@kernel.crashing.org>
Cc: Ivan Korzakow <ivan.korzakow@gmail.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GPIO device class driver
Date: Wed, 1 Feb 2006 01:00:27 -0600
To: Robert Schwebel <r.schwebel@pengutronix.de>
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 21, 2005, at 5:50 AM, Robert Schwebel wrote:

> Ivan,
>
> On Wed, Dec 21, 2005 at 12:07:27PM +0100, Ivan Korzakow wrote:
>> I read about a generic device class driver (http:// 
>> marc.theaimsgroup.com/?l=
>> linux-kernel&m=109419719600753&w=2) for GPIO. I wanted to know if  
>> anything
>> generic finally came out of the dicussion ?
>> I'm willing to write a gpio driver and I am considering taking  
>> Robert Schwebel
>> patch into it if nothing exist in the main line.
>
> As far as I know there is nothing new available yet; the LED framework
> people have don some things, but it should be "above" GPIO. This  
> morning
> we have discussed serveral things which could be improved in our code;
> if you are interested I'll keep you informed about the progress.
>
> Robert

Any further progress on this.  I'm looking at the GPIO's on an  
embedded PowerPC and would prefer to produce a driver towards a  
standard kernel interface.  I'm also happy to help on the standard  
interface if it needs some work.

- kumar
