Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262279AbSJOARO>; Mon, 14 Oct 2002 20:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJOARM>; Mon, 14 Oct 2002 20:17:12 -0400
Received: from franka.aracnet.com ([216.99.193.44]:18089 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262273AbSJOARL>; Mon, 14 Oct 2002 20:17:11 -0400
Date: Mon, 14 Oct 2002 17:20:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <2004595005.1034616026@[10.10.2.3]>
In-Reply-To: <3DAB5DF2.5000002@us.ibm.com>
References: <3DAB5DF2.5000002@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>> 4) An ordered zone list is probably the more natural mapping.
> See my comments above about per zone/memblk.  And you reemphasize my point, how do we order the zone lists in such a way that a user of the API can easily know/find out what zone #5 is?

Could you explain how that problem is different from finding out
what memblk #5 is ... I don't see the difference?

M.

