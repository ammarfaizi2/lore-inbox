Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269012AbTBWXkg>; Sun, 23 Feb 2003 18:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269016AbTBWXkg>; Sun, 23 Feb 2003 18:40:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16855 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S269012AbTBWXkf>; Sun, 23 Feb 2003 18:40:35 -0500
Date: Sun, 23 Feb 2003 15:50:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Anderson <andmike@us.ibm.com>
cc: Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bug with (maybe not *in*) sysfs
Message-ID: <33870000.1046044241@[10.10.2.4]>
In-Reply-To: <20030223234517.GA3158@beaverton.ibm.com>
References: <5480000.1046028715@[10.10.2.4]>
 <Pine.LNX.4.33.0302231310500.923-100000@localhost.localdomain>
 <20030223202401.GA1452@beaverton.ibm.com> <12070000.1046032398@[10.10.2.4]>
 <20030223234517.GA3158@beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, so two similar, but not identical cards using the same driver?
>> First patch mentioned looks very simple, but won't apply to 2.5.62
> 
> Are you seeing this problem on 2.5.62? The registration problem I
> described should be gone in 2.5.62.

Yup. But I can't see it now we avoided a VM bug ... maybe it was indirect
fallout from that ... sorry. If it's still happening, and I just missed it,
will let you know. Thanks for the help,

M.



