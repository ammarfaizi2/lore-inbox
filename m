Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262425AbTCPGhf>; Sun, 16 Mar 2003 01:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTCPGhf>; Sun, 16 Mar 2003 01:37:35 -0500
Received: from franka.aracnet.com ([216.99.193.44]:10474 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262425AbTCPGhe>; Sun, 16 Mar 2003 01:37:34 -0500
Date: Sat, 15 Mar 2003 22:48:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <19840000.1047797300@[10.10.2.4]>
In-Reply-To: <20030316063151.GA7114@gnuppy.monkey.org>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]> <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]> <20030316044524.GA6757@gnuppy.monkey.org> <12150000.1047793549@[10.10.2.4]> <20030316063151.GA7114@gnuppy.monkey.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Mar 15, 2003 at 09:45:50PM -0800, Martin J. Bligh wrote:
>> Erg. Could you send me your config file?
> 
> Attached:

# CONFIG_SMP is not set
CONFIG_X86_SUMMIT=y

That'll probably confuse the snot out of it ;-)
I'll try to add a dependency to the config file, but for now, can
you turn SMP on, and check that fixes it?

Thanks,

M.


