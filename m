Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSGNP6o>; Sun, 14 Jul 2002 11:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSGNP6n>; Sun, 14 Jul 2002 11:58:43 -0400
Received: from codepoet.org ([166.70.99.138]:63207 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S316903AbSGNP6n>;
	Sun, 14 Jul 2002 11:58:43 -0400
Date: Sun, 14 Jul 2002 10:01:35 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Joerg Schilling <schilling@fokus.gmd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020714160134.GB5440@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Joerg Schilling <schilling@fokus.gmd.de>,
	linux-kernel@vger.kernel.org
References: <200207141232.g6ECWF5n019043@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207141232.g6ECWF5n019043@burner.fokus.gmd.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jul 14, 2002 at 02:32:15PM +0200, Joerg Schilling wrote:
> >Eric Anderson wrote:
> 
> >cdrecord should use the CDROM_SEND_PACKET ioctl, then it would
> >work regardless,
> 
> This only prooves that you are uninformed :-(

No.  This only proves _you_ have not tried it.  I've used the
CDROM_SEND_PACKET ioctl on both SCSI and ATAPI cdrom devices.
What do you need to do in cdrecord that cannot be done with it?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
