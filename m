Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311434AbSCVJWX>; Fri, 22 Mar 2002 04:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311464AbSCVJWN>; Fri, 22 Mar 2002 04:22:13 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:13473 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311434AbSCVJV6>; Fri, 22 Mar 2002 04:21:58 -0500
Date: Fri, 22 Mar 2002 11:12:14 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3-ac5
In-Reply-To: <20020322101520.A16964@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0203221110530.2084-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Jörn Engel wrote:

> "handler not null, ..."
> if (...handler == NULL) BUG();
> 
> I am completely unaware of the real problem, but this doesn't match,
> does it?

ooh, Andre just pointed that out.

Thanks,
	Zwane


