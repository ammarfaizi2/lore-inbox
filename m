Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbTCPFhx>; Sun, 16 Mar 2003 00:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262462AbTCPFhx>; Sun, 16 Mar 2003 00:37:53 -0500
Received: from franka.aracnet.com ([216.99.193.44]:32391 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262452AbTCPFhw>; Sun, 16 Mar 2003 00:37:52 -0500
Date: Sat, 15 Mar 2003 21:48:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Eli Carter'" <eli.carter@inet.com>,
       "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: kgdb (kernel debugger)
Message-ID: <12600000.1047793718@[10.10.2.4]>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780AFB144E@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C780AFB144E@orsmsx116.jf.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Has anyone looked into getting kgdb working on 2.5?  On any
>> architecture?  (I'm mostly interested in XScale, but I thought I'd start
>> here in the hope that another arch has done the heavy lifting. ;) )
>> 
>> It does already, it's in both current -mm and -mjb trees. There was a
>> fancy new version floating around at one point, not sure what happened
>> to that, but the old one works fine.
> 
> Is there a way to get a separate patch w/o the whole -mm? (I guess I can do
> the required manual surgical separation, but asking is free :)

yeah, look in Andrew's broken-out directory. "kgdb.patch" or something.

M.

