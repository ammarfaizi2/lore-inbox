Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRHWQWF>; Thu, 23 Aug 2001 12:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbRHWQVz>; Thu, 23 Aug 2001 12:21:55 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:46599
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S268675AbRHWQVk>; Thu, 23 Aug 2001 12:21:40 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200108231606.f7NG6Lu26772@www.hockin.org>
Subject: Re: PDC20265 RAID signature
To: arjanv@redhat.com
Date: Thu, 23 Aug 2001 09:06:21 -0700 (PDT)
Cc: thockin@hockin.org (Tim Hockin), linux-kernel@vger.kernel.org
In-Reply-To: <3B84BB62.4571A0EF@redhat.com> from "Arjan van de Ven" at Aug 23, 2001 09:14:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Do you happen to know where the Promise "raid" controllers store the RAID
> > signature?  My crappy BIOS will only let me make a 2 disk array and 2x 1 disk
> > arrays.  I really would like 4 1 disk arrays so windows and Linux see the
> > same data, or 1 4 disk array...
> 
> see http://people.redhat.com/arjanv/pdcraid/

Thanks for the pointer!

Is there any reason to use this RAID over the md RAID layer?  This still
doesn't help me convince my BIOS to create a 4-disk array.  It will only
create a 2 disk array..

Tim
