Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTAWIFo>; Thu, 23 Jan 2003 03:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbTAWIFo>; Thu, 23 Jan 2003 03:05:44 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:25866 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S264950AbTAWIFn>; Thu, 23 Jan 2003 03:05:43 -0500
Date: Thu, 23 Jan 2003 19:14:35 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Jules Kongslie <chatos@omgwallhack.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cryptoloop in Linux 2.5
In-Reply-To: <20030122044043.GA4408@omgwallhack.org>
Message-ID: <Pine.LNX.4.44.0301231908050.25607-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Jules Kongslie wrote:

> I wondering about the status of encrypted loopback support in the 2.5
> kernel series. I know crypto-api was merged in, but I haven't been able
> to find any pointers about encrypting loopback devices, and I haven't
> seen any pointers to this after searching.
> 

Adam Richter has been doing some work on porting cryptoloop to the new 
API, and I'd guess that it will be fully supported reasonably soon
(discussion has been on cryptoapi-devel).


- James
-- 
James Morris
<jmorris@intercode.com.au>


