Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268998AbTCBLDP>; Sun, 2 Mar 2003 06:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269117AbTCBLDP>; Sun, 2 Mar 2003 06:03:15 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:1031 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S268998AbTCBLDO>; Sun, 2 Mar 2003 06:03:14 -0500
Date: Sun, 2 Mar 2003 22:13:12 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Brad Laue <brad@brad-x.com>
cc: Marc Giger <gigerstyle@gmx.ch>, <jt@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>, <breed@users.sourceforge.net>,
       <achirica@users.sourceforge.net>
Subject: Re: Cisco Aironet 340 oops with 2.4.20
In-Reply-To: <3E615134.8050907@brad-x.com>
Message-ID: <Pine.LNX.4.44.0303022210400.6149-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003, Brad Laue wrote:

> Yes.
> 
> In the attached is a full dump of three crashes. The first, at 18:14 
> occurs with NVdriver loaded, and the subsequent two occur with a system 
> which has booted without being touched by NVdriver.

The latter two are still happening with a tainted kernel.  Are you able to 
generate the crash if these modules have never been loaded?


- James
-- 
James Morris
<jmorris@intercode.com.au>



