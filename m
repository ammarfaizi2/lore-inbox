Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130173AbRB1N5u>; Wed, 28 Feb 2001 08:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130175AbRB1N5h>; Wed, 28 Feb 2001 08:57:37 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:59914 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S130173AbRB1N5X>; Wed, 28 Feb 2001 08:57:23 -0500
From: Robert van der Meulen <rvdm@NOSPAMlin-gen.com>
Subject: Re: Undo Loss msgs from 2.4.2ac5
Date: Wed, 28 Feb 2001 13:57:26 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <97j046$fhh$1@voyager.cistron.net>
In-Reply-To: <3A9D026D.3D5E3CE7@gte.net>
X-Trace: voyager.cistron.net 983368646 15921 62.216.31.57 (28 Feb 2001 13:57:26 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen Clark <sclark46@gte.net> wrote:
> Feb 28 08:22:12 pc-sec kernel: Undo loss 24.96.49.185/22 c2 l0 ss2/65535
> p0
They're debugging messages from the network layer.

> Can anyone tell me what these messages mean? It looks like they are
> coming from
> Should I worry about them?
No. you can switch them off by setting FASTRETRANS_DEBUG to '1' in 
include/net/tcp.h.

Greets,
	Robert

-- 
				Linux Generation

