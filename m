Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314085AbSDQVEl>; Wed, 17 Apr 2002 17:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314106AbSDQVEk>; Wed, 17 Apr 2002 17:04:40 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:36750 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S314085AbSDQVEk>; Wed, 17 Apr 2002 17:04:40 -0400
Date: Wed, 17 Apr 2002 14:24:38 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Robert Love <rml@tech9.net>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
Message-ID: <20020417142438.A27778@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.44.0204171358380.21779-100000@skuld.mtroyal.ab.ca> <1833210000.1019077852@flay> <1019074547.1670.98.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Beware!  I have seen lockups and driver sickness with hyperthreading 
enabled on some motherboards.  Most notably, Tyan with 2.4.19 and
2.5.6.  


Jeff

On Wed, Apr 17, 2002 at 04:15:42PM -0400, Robert Love wrote:
> On Wed, 2002-04-17 at 17:10, Martin J. Bligh wrote:
> > > Total of 4 processors activated (14299.95 BogoMIPS).
> > 
> > Before you get too excited about that, how much performance boost do 
> > you actually get by turning on Hyperthreading? ;-)
> 
> Certainly not the mips*4 that bogomips is showing :)
> 
> I guess that is a "bug" ?
> 
> 	Robert Love
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
