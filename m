Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278403AbRJMUix>; Sat, 13 Oct 2001 16:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278405AbRJMUif>; Sat, 13 Oct 2001 16:38:35 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:1158 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S278403AbRJMUiW>; Sat, 13 Oct 2001 16:38:22 -0400
Message-ID: <3BC8A65D.246AAC0B@bigfoot.com>
Date: Sat, 13 Oct 2001 13:38:53 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Development Setups
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was thinking of starting with a modern machine for developing/compiling on,
> and then older machine(s) for testing.  This way I would not risk losing data

I use the 'fast/slow' model for app server development.  The fastest
machine is used to build kernels for the slower test machine(s)
regardless of architecture or latest/greatest hardware.  Most results
can be scaled once you understand interactions.  NFS w no_root_squash is
useful provided a secure LAN.

rgds,
tim.
--
