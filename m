Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267458AbTAGS2A>; Tue, 7 Jan 2003 13:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267460AbTAGS2A>; Tue, 7 Jan 2003 13:28:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:9118 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267458AbTAGS17>;
	Tue, 7 Jan 2003 13:27:59 -0500
Date: Tue, 07 Jan 2003 10:44:58 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: karim@opersys.com, linux-kernel <linux-kernel@vger.kernel.org>
cc: hannal@us.ibm.com, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] High-speed data relay filesystem
Message-ID: <9370000.1041965097@w-hlinder>
In-Reply-To: <3E1B17DF.BCC51B3@opersys.com>
References: <3E1B17DF.BCC51B3@opersys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, January 07, 2003 01:09:35 PM -0500 Karim Yaghmour <karim@opersys.com> wrote:

> 
> As I mentioned earlier on this list, there is an increasing number
> of facilities and tools that need to relay large amounts of data from
> kernel space to user space. Up to this point, each of these has had
> its own mechanism for relaying data. The following is a proposal to
> implement a "high-speed data relay filesystem" (relayfs) that would
> supersede the individual mechanisms. As such, things like LTT, printk,

	Karim, This seeems like a good idea. A standard mechanism
for tools to access kernel info could be very useful. Im curious
what other people who work on tools think about this?

Hanna


