Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318626AbSHBGll>; Fri, 2 Aug 2002 02:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318635AbSHBGll>; Fri, 2 Aug 2002 02:41:41 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:29934 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318626AbSHBGlk>;
	Fri, 2 Aug 2002 02:41:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15690.10852.935317.603783@napali.hpl.hp.com>
Date: Thu, 1 Aug 2002 23:44:52 -0700
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       riel@conectiva.com.br, akpm@zip.com.au, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, rohit.seth@intel.com, sunil.saxena@intel.com,
       asit.k.mallick@intel.com
Subject: Re: large page patch 
In-Reply-To: <868823061.1028244804@[10.10.2.3]>
References: <15690.9727.831144.67179@napali.hpl.hp.com>
	<868823061.1028244804@[10.10.2.3]>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 01 Aug 2002 23:33:26 -0700, "Martin J. Bligh" <Martin.Bligh@us.ibm.com> said:

  DaveM> In my opinion the proposed large-page patch addresses a
  DaveM> relatively pressing need for databases (primarily).
  >>
  DaveM> Databases want large pages with IPC_SHM, how can this special
  DaveM> syscal hack address that?

  >>  I believe the interface is OK in that regard.  AFAIK, Oracle is
  >> happy with it.

  Martin> Is Oracle now the world's only database? I think not.

I didn't say such a thing.  I just don't know what other db vendors/authors
think of the proposed interface.  I'm sure their feedback would be welcome.

	--david
