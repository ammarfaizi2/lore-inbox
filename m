Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUHIOOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUHIOOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 10:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUHIONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 10:13:08 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:53180 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266610AbUHIOMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 10:12:51 -0400
Date: Mon, 9 Aug 2004 16:12:07 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091412.i79EC7iR010554@burner.fokus.fraunhofer.de>
To: alan@lxorguk.ukuu.org.uk, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, eric@lammerts.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Alan Cox <alan@lxorguk.ukuu.org.uk>

>> On Solaris, there is ACLs, RBAC & getppriv() / setppriv()
>> 
>> http://docs.sun.com/db/doc/816-5167/6mbb2jaeu?a=expand

>and Linux has capabilities, ACLs and SELinux rulesets which can
>also be used to manage this. I can give the cd burner a role that 
>permits it certain things.

If you are right, why then is SuSE removing the warnings in cdrecord
that are there to tell the user that cdrecord is running with insufficient 
privilleges?

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
