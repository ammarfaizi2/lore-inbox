Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313977AbSDQAVl>; Tue, 16 Apr 2002 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313982AbSDQAVk>; Tue, 16 Apr 2002 20:21:40 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44806
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313977AbSDQAVj>; Tue, 16 Apr 2002 20:21:39 -0400
Date: Tue, 16 Apr 2002 17:21:06 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam1
In-Reply-To: <20020417000351.GC1800@werewolf.able.es>
Message-ID: <Pine.LNX.4.10.10204161720260.10691-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a micro bug in 3a, look for 4 to arrive.

regards

On Wed, 17 Apr 2002, J.A. Magallon wrote:

> Hi.
> 
> New version, just collected latest important bugfixes:
> 
> - Serial port number assign (05-serial.gz)
> - pagemap.h include for fs/ (04-fs-pagemap.gz)
> - unlocking order in buffer.c::end_buffer_io_kiobuf (03-unlock-bh-before.gz)
> 
> And a couple new additions:
> 
> - ide update -3a (very shrinked wrt original, the big ppc part has gone
>   in mainline)
> - netconsole-C2-2 (for my beowulf...)
> 
> Rest as usual, O1-sched-k3 (is any backport of the updates planned ??)
> mini-low-lat, splitted-vm-33, bproc-3.1.9.
> 
> Enjoy !!
> 
> -- 
> J.A. Magallon                           #  Let the source be with you...        
> mailto:jamagallon@able.es
> Mandrake Linux release 8.3 (Cooker) for i586
> Linux werewolf 2.4.19-pre7-jam1 #1 SMP Wed Apr 17 00:42:27 CEST 2002 i686
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

