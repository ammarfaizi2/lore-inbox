Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTH0NF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbTH0NF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:05:56 -0400
Received: from mail.permas.de ([195.143.204.226]:33198 "EHLO netserv.local")
	by vger.kernel.org with ESMTP id S263364AbTH0NFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:05:55 -0400
From: Hartmut Manz <manz@intes.de>
Organization: INTES GmbH
To: linux-kernel@vger.kernel.org
Subject: Which U320 SCSI controler can be used on IA64 Systems
Date: Wed, 27 Aug 2003 15:05:53 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308271505.53086.manz@intes.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I need to extend an ITANIUM-2 system with a 4 way striped scratch file-system.
Now I am looking for working U320 SCSI controllers.

Could anyone tell me which SCSI controller is working on IA64.

My Idea was to use the ADAPTEC Controller 39320D with 
2 * 2 external Seagate 15K3 Disk and to use softraid.
Is this a good choice? 

The used operating system is RedHat AS2.1
Compiling a new kernel is no problem.

Thank You in advance

Hartmut
-- 
-----------------------------------------------------------------------------
Hartmut Manz                                      WWW:    http://www.intes.de
INTES GmbH                                        Phone:  +49-711-78499-29
Schulze-Delitzsch-Str. 16                         Fax:    +49-711-78499-10
D-70565 Stuttgart                                 E-mail: manz@intes.de
   Ein Mensch sieht, was vor Augen ist; der Herr aber sieht das Herz an.
------------------------------------------------------- 1. Samuel 16, 7 -----

