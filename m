Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319098AbSHFMmF>; Tue, 6 Aug 2002 08:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319099AbSHFMmF>; Tue, 6 Aug 2002 08:42:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52473 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319098AbSHFMmE>; Tue, 6 Aug 2002 08:42:04 -0400
Subject: Re: [PATCH] NUMA-Q xquad_portio declaration
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <349340000.1028591613@flay>
References: <349340000.1028591613@flay>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 15:04:28 +0100
Message-Id: <1028642668.18130.159.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 00:53, Martin J. Bligh wrote:
> This patch is from Matt Dobson. It corrects the definition of
> xquad_portio, getting rid of a compile warning.

Marcelo - I have a much cleaner change for this.

