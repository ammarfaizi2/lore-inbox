Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310474AbSCLHYW>; Tue, 12 Mar 2002 02:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310460AbSCLHYN>; Tue, 12 Mar 2002 02:24:13 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:45210 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S310468AbSCLHX4>; Tue, 12 Mar 2002 02:23:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Tony Hoyle <tmh@nothing-on.tv>, linux-kernel@vger.kernel.org
Subject: Re: Dog slow IDE
Date: Tue, 12 Mar 2002 01:23:38 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C8CB3EB.8070704@nothing-on.tv>
In-Reply-To: <3C8CB3EB.8070704@nothing-on.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020312072348.WUOR1214.rwcrmhc54.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 11, 2002 07:40, Tony Hoyle wrote:
> For some reason the my IDE is running extremely slow (which accounts for
> why this box feels so sluggish).

Are they dog slow after a *cold* start?  My solution to slow Maxtor drives 
was to fix the CPU fans in my machine and put the main drive in a bay cooler. 
 The drive wasn't spewing bad data, so it wasn't the drive controller 
overheating.  That leads me to believe that the motor (or the motor control 
DSP) was overheating and degrading performance on that route.  Trying that 
will save you lots of hours toying with hdparm like I did :).

Good luck..its a sucky problem but once you get it fixed your machine will 
seem like new!
-- 
akk~
