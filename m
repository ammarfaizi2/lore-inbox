Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289162AbSAJEbs>; Wed, 9 Jan 2002 23:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289161AbSAJEbi>; Wed, 9 Jan 2002 23:31:38 -0500
Received: from 12-226-21-207.client.attbi.com ([12.226.21.207]:64244 "EHLO
	spartan.jdc.home") by vger.kernel.org with ESMTP id <S289160AbSAJEb1>;
	Wed, 9 Jan 2002 23:31:27 -0500
Message-ID: <3C3D191E.7090804@noth.is.eleet.ca>
Date: Wed, 09 Jan 2002 23:31:26 -0500
From: Jim Crilly <noth@noth.is.eleet.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Chris Ball <chris@void.printf.net>
CC: Benjamin S Carrell <ben@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Bigggg Maxtor drives (fwd)
In-Reply-To: <20020110040308.A28692@void.printf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually it would seem this is just Andre's, not so subtle, way of 
trying to prove that his ATA133/48-bit addressing patches need included 
in 2.4.

-Jim

Chris Ball wrote:

> On Wed, Jan 09, 2002 at 08:14:32PM -0700, Benjamin S Carrell wrote:
> 
>>I would think that you lose that space to formatting
>>
> 
> That would be irrelevant.  We're looking at the kernel's summation of
> the geometry, not the filesystem's description of usable space.
> 
> 
>>(would it not get the size of the drive from the bios?)
>>
> 
> No, the kernel tends not to rely on the BIOS for geometry.  Which is
> usually very wise.
> 
> 
>>but I stand open for correction.
>>
> 
> Same here.  It's always a good idea.  :-)
> 
> Is this perhaps Maxtor providing their own 'non-standard'[1] definition
> of gigabyte, rather than a technical issue?
> 
> - Chris.
> 
> [1]: (viz. 'wrong')
> 


