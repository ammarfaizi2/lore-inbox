Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312694AbSDSUbQ>; Fri, 19 Apr 2002 16:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312790AbSDSUbP>; Fri, 19 Apr 2002 16:31:15 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44297
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312694AbSDSUbO>; Fri, 19 Apr 2002 16:31:14 -0400
Date: Fri, 19 Apr 2002 13:30:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Heinz Diehl <hd@cavy.de>
cc: linux-kernel@vger.kernel.org, jmagallon@able.es
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
In-Reply-To: <20020419140520.GA1687@chiara.cavy.de>
Message-ID: <Pine.LNX.4.10.10204191329230.19117-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for the positive report ! :-)

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Fri, 19 Apr 2002, Heinz Diehl wrote:

> On Thu Apr 18 2002, J.A. Magallon wrote:
> 
> > >I also changed '#if 1' to '#if 0' as Andre mentioned but it has no effect,
> > >my machine hangs at boot time....
> 
> > It worked for me, just booted fine with hdparm included...
> 
> I just merged "ide-2.4.19-p7.all.convert.5.patch" into my tree, and now
> it works also for me. With former versions my machine hung at boot time,
> wether #if 0 or 1 was set.
> 
> -- 
> # Heinz Diehl, 68259 Mannheim, Germany
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

