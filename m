Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTLEQsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTLEQsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:48:53 -0500
Received: from bay9-f11.bay9.hotmail.com ([64.4.47.11]:30729 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S264288AbTLEQsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:48:51 -0500
X-Originating-IP: [200.150.144.150]
X-Originating-Email: [lukels@hotmail.com]
From: "A. S." <lukels@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Compiling SCSI driver (Adaptec aic7xxx)
Date: Fri, 05 Dec 2003 16:48:50 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY9-F11LdP4GLqfjE70001985b@hotmail.com>
X-OriginalArrivalTime: 05 Dec 2003 16:48:51.0034 (UTC) FILETIME=[A9198BA0:01C3BB4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling SCSI driver (Adaptec aic7xxx):

aicasm_symbol.c:39: db1/db.h: No such file or directory

No "db.h" was found in the source code.
It wasn't renamed, because i couldn't even find the variables used in 
aicasm_symbol.c
(like DB_HASH).

Luke

_________________________________________________________________
MSN Messenger: converse com os seus amigos online.  
http://messenger.msn.com.br

