Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRDFT1b>; Fri, 6 Apr 2001 15:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRDFT1L>; Fri, 6 Apr 2001 15:27:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44939 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132318AbRDFT1B>;
	Fri, 6 Apr 2001 15:27:01 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15054.6234.937338.323857@pizda.ninka.net>
Date: Fri, 6 Apr 2001 12:26:18 -0700 (PDT)
To: Kevin Stone <kstone@trivergent.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 tcp window id causes problems talking to windows clients
In-Reply-To: <3ACE14EA.2030502@trivergent.net>
In-Reply-To: <3ACE14EA.2030502@trivergent.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kevin Stone writes:
 > Is there any plan to include the zerocopy patches into the stock kernel? 
 >   The win2k dial-up/window id problem is really a showstopper but hasn't 
 > generated much traffic on lkml or the digests. 

I submitted the patch to Linus, it will likely go into 2.4.4
but if not I'll submit the ID patch seperately.

Later,
David S. Miller
davem@redhat.com
