Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSHIJPU>; Fri, 9 Aug 2002 05:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318214AbSHIJPU>; Fri, 9 Aug 2002 05:15:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18427 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318213AbSHIJPU>; Fri, 9 Aug 2002 05:15:20 -0400
Subject: Re: no DMA on 2.4.20-pre1 on ICH4 (2.4.19-rc*-ac* did)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020809090523.GB23783@ulima.unil.ch>
References: <20020809090523.GB23783@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 11:38:50 +0100
Message-Id: <1028889530.30103.192.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 10:05, Gregoire Favre wrote:
> Any hope to include that in pre2?

Maybe pre3/pre4. pre2 will have some other stuff that is also important
and affects the IDE merge. The IDE stuff has a couple of bits I want to
pin down as well.

For most cases if I push Marcelo the pci interface changes that ought to
fix things.
