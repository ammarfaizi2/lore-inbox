Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSAMJj7>; Sun, 13 Jan 2002 04:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287984AbSAMJju>; Sun, 13 Jan 2002 04:39:50 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:60055 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S287979AbSAMJjk>; Sun, 13 Jan 2002 04:39:40 -0500
Date: Sun, 13 Jan 2002 11:39:08 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Jim Studt <jim@federated.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <200201111732.g0BHWYhV003902@core.federated.com>
Message-ID: <Pine.LNX.4.33.0201131137510.28980-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you please try with kernel option "noapic", you don't have to
recompile. I'd just like to know wether the problem persists. You might
find the box sharing a lot of IRQs though.

Regards,
	Zwane Mwaikambo


