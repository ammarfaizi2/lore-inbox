Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290620AbSBLARb>; Mon, 11 Feb 2002 19:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290634AbSBLARR>; Mon, 11 Feb 2002 19:17:17 -0500
Received: from codepoet.org ([166.70.14.212]:11473 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S290629AbSBLAPr>;
	Mon, 11 Feb 2002 19:15:47 -0500
Date: Mon, 11 Feb 2002 17:15:47 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-ac1
Message-ID: <20020212001547.GA22586@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200202112301.g1BN1Th00942@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200202112301.g1BN1Th00942@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.4.17-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 11, 2002 at 06:01:29PM -0500, Alan Cox wrote:
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.18pre9-ac1

I notice that in linux/drivers/scsi/scsi_merge.c you seem to
be reverting the MO drive clustering fix from Jens:
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.0/1321.html

Was this intentional?  If so, why?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
