Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbTCQSPq>; Mon, 17 Mar 2003 13:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbTCQSPq>; Mon, 17 Mar 2003 13:15:46 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6630
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261839AbTCQSPo>; Mon, 17 Mar 2003 13:15:44 -0500
Subject: re: Ptrace hole / Linux 2.2.25
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030317182040.GA2145@louise.pinerecords.com>
References: <200303171604.h2HG4Zc30291@devserv.devel.redhat.com>
	 <1047923841.1600.3.camel@laptop.fenrus.com>
	 <20030317182040.GA2145@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047929671.24510.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 17 Mar 2003 19:34:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-17 at 18:20, Tomas Szepe wrote:
> Is this critical enough for 2.4.21 to go out?  Or can it wait like
> some other fairly serious stuff such as the ext3 fixes?  What about
> the current state of IDE?
> 
> Would it make sense to repackage 2.4.20 into something like 2.4.20-p1
> or 2.4.20.1 with only the critical stuff applied?

If you build your own kernels apply the patch, if you use vendor kernels
then you can expect vendor kernel updates to appear or have already
appeared

