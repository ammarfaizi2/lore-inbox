Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSHFXIr>; Tue, 6 Aug 2002 19:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316503AbSHFXIr>; Tue, 6 Aug 2002 19:08:47 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:61707 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316500AbSHFXIq>; Tue, 6 Aug 2002 19:08:46 -0400
Date: Wed, 7 Aug 2002 00:12:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Adlung <Ingo.Adlung@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18/18 scsi core changes
Message-ID: <20020807001224.A16527@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Adlung <Ingo.Adlung@t-online.de>, linux-kernel@vger.kernel.org
References: <200208051830.50713.arndb@de.ibm.com> <200208052008.35187.arndb@de.ibm.com> <20020805181234.B16035@infradead.org> <200208061306.03627.arnd@bergmann-dalldorf.de> <20020806101807.A16350@infradead.org> <3D505758.8090002@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D505758.8090002@t-online.de>; from Ingo.Adlung@t-online.de on Wed, Aug 07, 2002 at 01:10:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 01:10:16AM +0200, Ingo Adlung wrote:
> > Following that argumentation we could also include the broken qlogic driver
> > and the nvidia glue..
> > 
> 
> Well, if the hardware implementation would always be straight forward to 
> what you know from PCs, it wouldn't be required to apply additional 
> patches to the common code, but it would be easy to stay within the 
> architecture specifics.

That above statement was about the horrible code quality of most if not
all s390 drivers.  Yes there are similarly bad vendor drivers around for
intel hardware - buf fortunately they are not in the tree.

