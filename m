Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319103AbSHFOnJ>; Tue, 6 Aug 2002 10:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319105AbSHFOnJ>; Tue, 6 Aug 2002 10:43:09 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27377 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319103AbSHFOnI>; Tue, 6 Aug 2002 10:43:08 -0400
Subject: Re: [PATCH] NUMA-Q xquad_portio declaration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
In-Reply-To: <1240460728.1028616442@[10.10.2.3]>
References: <1028642668.18130.159.camel@irongate.swansea.linux.org.uk> 
	<1240460728.1028616442@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 17:05:42 +0100
Message-Id: <1028649942.18130.172.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 14:47, Martin J. Bligh wrote:
> >> This patch is from Matt Dobson. It corrects the definition of
> >> xquad_portio, getting rid of a compile warning.
> > 
> > Marcelo - I have a much cleaner change for this.
> 
> Can you publish it? ;-)

I did - its in -ac4 

