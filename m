Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282167AbRKWPPH>; Fri, 23 Nov 2001 10:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282161AbRKWPO5>; Fri, 23 Nov 2001 10:14:57 -0500
Received: from t2.redhat.com ([199.183.24.243]:60404 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S282162AbRKWPOt>; Fri, 23 Nov 2001 10:14:49 -0500
Message-ID: <3BFE67E8.CFA0D371@redhat.com>
Date: Fri, 23 Nov 2001 15:14:48 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <3BFE591B.D1F75CD5@starband.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:
> 
> #1) The compiler from redhat (gcc-2.96) is not an official GNU release.
> #2) http://www.atnf.csiro.au/~rgooch/linux/docs/kernel-newsflash.html/
>       "the reccomend compiler is now gcc-2.95.3, rather than gcc-2.91.66"

>From Documentation/Changes in 2.4.15:

The Red Hat gcc 2.96 compiler subtree can also be used to build this
tree.
You should ensure you use gcc-2.96-74 or later. gcc-2.96-54 will not
build
the kernel correctly.
