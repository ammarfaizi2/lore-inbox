Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUHVJPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUHVJPQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 05:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUHVJPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 05:15:16 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:9667 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S266598AbUHVJOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 05:14:50 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Brad Campbell'" <brad@wasp.net.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 12:14:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <41285DB3.6070605@wasp.net.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSIJJ7wfQIqxlydS1qy90CZVF8lEQAC+Kgg
Message-Id: <S266598AbUHVJOu/20040822091450Z+189@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is certainly the solution to the issue. Indeed, everything works fine
including NAT because the hack is in the kernel level. Your assistance is
greatly appreciated. The first issue is complete but for now I think I will
get into a lesser one. (I will write about it when I get have all the
details)

Best Regards...

-----Original Message-----
From: Brad Campbell [mailto:brad@wasp.net.au] 
Sent: Sunday, August 22, 2004 10:48 AM
To: Josan Kadett
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

No.. this should work for you.. Try it and see anyway.

Regards,
Brad




