Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318736AbSIFPas>; Fri, 6 Sep 2002 11:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318735AbSIFPas>; Fri, 6 Sep 2002 11:30:48 -0400
Received: from robur.slu.se ([130.238.98.12]:25607 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S318736AbSIFP3n>;
	Fri, 6 Sep 2002 11:29:43 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15736.52203.840229.604858@robur.slu.se>
Date: Fri, 6 Sep 2002 17:38:19 +0200
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@redhat.com>, akpm@zip.com.au, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <46676537.1031297834@[10.10.2.3]>
References: <15736.38178.445310.714015@robur.slu.se>
	<46676537.1031297834@[10.10.2.3]>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin J. Bligh writes:


 > We are running from 2.5.latest ... any updates needed for NAPI for the
 > driver in the current 2.5 tree, or is that OK?

 Should be OK. Get latest kernel e1000 to get Intel's and maintainers latest 
 work and apply the e1000 NAPI patch. RH includes this patch?

 And yes there are plenty of room for improvements...


 Cheers.
						--ro

