Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUHVMPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUHVMPO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUHVMPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:15:14 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5083 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266684AbUHVMPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:15:07 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 22 Aug 2004 14:14:08 +0200
To: schilling@fokus.fraunhofer.de, der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <41288E10.nail9MX3BDIPM@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner> <412889FC.nail9MX1X3XW5@burner>
In-Reply-To: <412889FC.nail9MX1X3XW5@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Pascal Schmidt <der.eremit@email.de> wrote:

>> I am not against a long term change that would require euid root too,
>> but this should be announced early enough to allow prominent users of
>> the interface to keep track of the interface changes.

>Too late for that now, no matter whether we like it or not... however,
>at least the discussion now has shown that changes to this interface
>need to be considered carefully, so maybe the future will be
>bright. ;)

Eveybody makes mistakes. Not being able to admid that and persisting to 
continue to go in a wrong direction is the real problem.

There is no problem to do what I did propose.

And the wrong decision could have even be avoided if people did contact me
before they did act....


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
