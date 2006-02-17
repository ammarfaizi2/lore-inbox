Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWBQVxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWBQVxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWBQVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:53:52 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:52681 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750859AbWBQVxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:53:52 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 17 Feb 2006 22:52:08 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F64588.nail3BO1TI7E1@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <20060216115204.GA8713@merlin.emma.line.org>
 <43F4BF26.nail2KA210T4X@burner>
 <200602161742.26419.dhazelton@enter.net>
 <43F5B686.nail2VCA2A2OF@burner>
 <Pine.LNX.4.61.0602171643560.27452@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602171643560.27452@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >Sorry, the way to access SCSI generic via /dev/hd* is deprecated. If ide-scsi
> >ir removed, then a clean and orthogonal way of accessing SCSI in a generic
> >way is removed from Linux. If Linux does nto care about orthogonality of 
> >interfaces, this is a problem of the people who are responbile for the related
> >interfaces.
> >
>
> So what you want is to be able to use write() on a <sg-compatible> device 
> rather than doing SG_IO ioctl() on <any> device?

This kind of disinformation is what constantly puts fuel into the fire....

Are you a victim of the firebugs in this list?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
