Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSHBG4K>; Fri, 2 Aug 2002 02:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318729AbSHBG4K>; Fri, 2 Aug 2002 02:56:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44049 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318704AbSHBG4J>;
	Fri, 2 Aug 2002 02:56:09 -0400
Message-ID: <3D4A3002.FFED947E@zip.com.au>
Date: Fri, 02 Aug 2002 00:08:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       rohit.seth@intel.com, sunil.saxena@intel.com, asit.k.mallick@intel.com
Subject: Re: large page patch
References: <15690.9727.831144.67179@napali.hpl.hp.com> <868823061.1028244804@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >   DaveM>    In my opinion the proposed large-page patch addresses a
> >   DaveM> relatively pressing need for databases (primarily).
> >
> >   DaveM> Databases want large pages with IPC_SHM, how can this
> >   DaveM> special syscal hack address that?
> >
> > I believe the interface is OK in that regard.  AFAIK, Oracle is happy
> > with it.
> 
> Is Oracle now the world's only database? I think not.

Is a draft of Simon's patch available against 2.5?

-
