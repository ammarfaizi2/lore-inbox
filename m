Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTIUNuW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 09:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTIUNuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 09:50:22 -0400
Received: from sea2-f31.sea2.hotmail.com ([207.68.165.31]:30992 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262409AbTIUNuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 09:50:21 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL MACRO definition (in 2.4.18-3) - newbie
Date: Sun, 21 Sep 2003 15:50:18 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F317wbaj3ywtsI00006dd5@hotmail.com>
X-OriginalArrivalTime: 21 Sep 2003 13:50:18.0719 (UTC) FILETIME=[4B14BEF0:01C38047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ,
I want to know where EXPORT_SYMBOL macro is defined  (in 2.4.18-3 kernel).

I saw in module.h that there are some #ifndef EXPORT_SYMBOL
that print an error if this symbols is nor defined , but searching
in the kernel sources did not gave me more results.

I also saw in the kernel Makefile that EXPORT_SYMBOL
appears in tags, but I do'nt know how to find the definition
for this macro.

Does somebody know ?

regards,
sting

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

