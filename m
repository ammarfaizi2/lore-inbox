Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTB0ONU>; Thu, 27 Feb 2003 09:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTB0ONU>; Thu, 27 Feb 2003 09:13:20 -0500
Received: from kestrel.vispa.uk.net ([62.24.228.12]:12563 "EHLO
	kestrel.vispa.uk.net") by vger.kernel.org with ESMTP
	id <S265037AbTB0ONT>; Thu, 27 Feb 2003 09:13:19 -0500
Message-ID: <3E5E1F49.3090106@walrond.org>
Date: Thu, 27 Feb 2003 14:23:05 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /proc/cpuinfo shows only 2 processors on dual P4-Xeon system
References: <F760B14C9561B941B89469F59BA3A8471380D0@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 4 cpu's! Hoorah!

Either I made stupid mistake yesterday, or changes got in a bk pull this 
morning (I noticed apic.c had changed) solved it.

Either way, the problem is resolved - thanks!

Andrew Walrond


