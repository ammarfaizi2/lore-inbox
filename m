Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287109AbSAPSoq>; Wed, 16 Jan 2002 13:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287051AbSAPSoi>; Wed, 16 Jan 2002 13:44:38 -0500
Received: from [66.89.142.2] ([66.89.142.2]:63022 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S286127AbSAPSoZ>;
	Wed, 16 Jan 2002 13:44:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: initramfs buffer spec -- second draft
Date: Tue, 15 Jan 2002 07:34:44 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QNBs-00007R-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 09:39 pm, Alexander Viro wrote:
> On 13 Jan 2002, Eric W. Biederman wrote:
> 
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> > > This is an update to the initramfs buffer format spec I posted
> > > earlier.  The changes are as follows:
> > 
> > Comments.  Endian issues are not specified, is the data little, big
> > or vax endian?
> 
> Data is what you put into files, byte-by-byte.  Headers are ASCII.

Is there a problem with the available tools, are they not capable of 
generating the binary version of the headers?

--
Daniel
