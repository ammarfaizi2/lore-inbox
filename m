Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVCTGqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVCTGqR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 01:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVCTGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 01:46:17 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:10929 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262027AbVCTGqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 01:46:11 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Diego Calleja <diegocg@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Date: Sat, 19 Mar 2005 22:44:01 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
In-Reply-To: <1110827273.14842.3.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0503192241450.18353@qynat.qvtvafvgr.pbz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com><Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz><20050314083717.GA19337@elf.ucw.cz><200503140855.18446.jbarnes@engr.sgi.com><20050314191230.3eb09c37.diegocg@gmail.com>
 <1110827273.14842.3.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Lee Revell wrote:

> On Mon, 2005-03-14 at 19:12 +0100, Diego Calleja wrote:
>> Why should people look at all that "horrid" debug info everytime
>> they boot, except when they have a problem?
>
> I'm really not trolling, but I suspect if we made the boot process less
> verbose, people would start to wonder more about why Linux takes so much
> longer than XP to boot.

two things

1. linux shouldn't take longer to boot then windows (and if properly 
configured it doesn't)

2. there's a _long_ way between the current situation where a driver can 
spew 500+ lines of logging and there being so little logging that people 
don't know what's going on.

if you are on a slow console (say a serial console) just letting the boot 
messages scroll by can take quite a while today.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
