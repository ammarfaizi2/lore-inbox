Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbSJ3TQI>; Wed, 30 Oct 2002 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264868AbSJ3TQH>; Wed, 30 Oct 2002 14:16:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:48078 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264825AbSJ3TQG>; Wed, 30 Oct 2002 14:16:06 -0500
Date: Wed, 30 Oct 2002 11:17:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: post-halloween 0.2
Message-ID: <765420000.1036005439@flay>
In-Reply-To: <1036006381.5297.108.camel@irongate.swansea.linux.org.uk>
References: <20021030171149.GA15007@suse.de> <1036006381.5297.108.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you also mention not using gcc 3.0.x (stack pointer handling bug)

Any chance of putting this sort of thing as #error detection
in the compile so it auto-breaks? I seem to recall that's done
for some versions of GCC already ...

M.

