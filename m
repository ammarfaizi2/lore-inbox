Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWBQNYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWBQNYS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWBQNYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:24:18 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:10453 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751407AbWBQNYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:24:17 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 17 Feb 2006 14:22:53 +0100
To: schilling@fokus.fraunhofer.de, mj@ucw.cz
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org, dhazelton@enter.net
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43F5CE2D.nail31P31133A@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
 <20060216115204.GA8713@merlin.emma.line.org>
 <43F4BF26.nail2KA210T4X@burner>
 <200602161742.26419.dhazelton@enter.net>
 <43F5B686.nail2VCA2A2OF@burner>
 <mj+md-20060217.115403.7981.albireo@ucw.cz>
In-Reply-To: <mj+md-20060217.115403.7981.albireo@ucw.cz>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares <mj@ucw.cz> wrote:

> > ir removed, then a clean and orthogonal way of accessing SCSI in a generic
> > way is removed from Linux. If Linux does nto care about orthogonality of 
> > interfaces, this is a problem of the people who are responbile for the related
> > interfaces.
>
> You open any SCSI device, you do SG_IO on it. What is non-orthogonal in that?

I encourage you to read the previous mails, this has been explained for more 
than ten times now.....

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
