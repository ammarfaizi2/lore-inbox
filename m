Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311206AbSCVJGT>; Fri, 22 Mar 2002 04:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311244AbSCVJGJ>; Fri, 22 Mar 2002 04:06:09 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:33946 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311206AbSCVJF4>; Fri, 22 Mar 2002 04:05:56 -0500
Date: Fri, 22 Mar 2002 10:56:22 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19-pre3-ac5
In-Reply-To: <20020322095628.A28751@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0203221054060.2084-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Jörn Engel wrote:

> The code appears to be too paranoid here. In case noone else submitted
> a patch yet, here is mine.
> Apply with patch -p0.

Actually that exact problem is present in 2.5 as well without the BUG 
check, "handler not null, timer being added twice blah blah..." there 
really is a problem.

	Zwane


