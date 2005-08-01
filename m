Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVHASAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVHASAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVHASAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:00:22 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:12251 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S261329AbVHASAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:00:19 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: ECC Support in Linux
Date: Mon, 1 Aug 2005 13:03:34 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1122770777.5473.1.camel@mindpipe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcWVYScVlFczGOAoSh+wY4AHhffe4wBYWoBw
Message-ID: <EXCHG2003DbH8J0sca0000007f8@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 01 Aug 2005 16:57:55.0642 (UTC) FILETIME=[29A0E1A0:01C596BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

I have had a fair amount of trouble with the limited support
for ecc reporting on higher end dual and quad cpu servers as
the reporting is pretty weak.

On the opterons I can tell which cpu gets errors, but mcelog
does not isolate things down to the dimm level properly, is
there a way to do this sort of thing?   I am talking about most
of the whitebox type motherboards.

On the newer Intels I have not found any useable ECC support
is there any in the kernels?

I can test a variety of hardware if someone needs it, and can
probably even come up with some test memory that will generate ecc
errors.

                     Roger   

