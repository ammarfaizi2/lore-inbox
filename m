Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289762AbSAOOgx>; Tue, 15 Jan 2002 09:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289776AbSAOOgo>; Tue, 15 Jan 2002 09:36:44 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:51375 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289762AbSAOOga>; Tue, 15 Jan 2002 09:36:30 -0500
Date: Tue, 15 Jan 2002 16:34:48 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: floating point exception
In-Reply-To: <1011043588.645.0.camel@sector17.home.at>
Message-ID: <Pine.LNX.4.33.0201151633300.2080-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2002, Christian Thalinger wrote:

> It seems the floating point exception is only raised with a new data
> package. Is there a simple way to raise such a exception?

New data package? And does the same behaviour re-occur after the fpu
exception? ie programs start segfaulting etc. Can you try doing a "dmesg"
after the segfaults and fpu exception and see if there is anything in the
kernel ring buffer too.

Regards,
	Zwane Mwaikambo


