Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293099AbSCEMvc>; Tue, 5 Mar 2002 07:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293105AbSCEMvX>; Tue, 5 Mar 2002 07:51:23 -0500
Received: from selui2.tetrapak.com ([195.163.136.92]:13287 "EHLO
	selui2.tetrapak.com") by vger.kernel.org with ESMTP
	id <S293099AbSCEMvR>; Tue, 5 Mar 2002 07:51:17 -0500
Message-ID: <154A5E546927D51197A200508BE1DEE983F2BE@chlaexh01.la.ch.tetrapak.com>
From: Cuendet JeanEric <JeanEric.Cuendet@tetralaval.com>
To: linux-kernel@vger.kernel.org
Subject: Hash table in kernel
Date: Tue, 5 Mar 2002 13:51:11 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Could someone tell me what to use to make an hashtable in the kernel?
Where to find info?

I'd like to make a simple hash table with ~10-100 entries (one per block
device)
I need the function : init(num_buckets), get_entry(hashkey),
add_entry(entry)

Thanks
-jec
