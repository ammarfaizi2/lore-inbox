Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314187AbSDREal>; Thu, 18 Apr 2002 00:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314188AbSDREak>; Thu, 18 Apr 2002 00:30:40 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:40335 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S314187AbSDREak>; Thu, 18 Apr 2002 00:30:40 -0400
Date: Wed, 17 Apr 2002 21:50:54 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: Hyperthreading
Message-ID: <20020417215054.A29118@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.44.0204171358380.21779-100000@skuld.mtroyal.ab.ca> <1833210000.1019077852@flay> <20020417142617.B27778@vger.timpanogas.org> <1871700000.1019089865@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 05:31:05PM -0700, Martin J. Bligh wrote:
> >> Before you get too excited about that, how much performance boost do 
> >> you actually get by turning on Hyperthreading? ;-)
> > 
> > In my testing with SCI, it speeds up some operations and with 3Ware 
> > it increases throuput about 10 MB/S.  Not a lot but there is some 
> > improvement (if you can get around the lockups during boot).
> 
> What's that 10MB/s as a percentage of the overall performance?
> 
> M.

247-251 (with) vs. 227-238 (without) MB/S

Jeff  


