Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTEMWgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTEMWgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:36:42 -0400
Received: from nmail1.systems.pipex.net ([62.241.160.130]:36805 "EHLO
	nmail1.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263447AbTEMWgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:36:41 -0400
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.6 must-fix list, v2
Message-ID: <1052866156.3ec1766c0b7b3@netmail.pipex.net>
Date: Tue, 13 May 2003 23:49:16 +0100
From: "Shaheed R. Haque" <srhaque@iee.org>
Cc: "Shaheed R. Haque" <srhaque@iee.org>, <linux-kernel@vger.kernel.org>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <1050177383.3e986f67b7f68@netmail.pipex.net> <1050177751.2291.468.camel@localhost> <1050222609.3e992011e4f54@netmail.pipex.net> <1050244136.733.3.camel@localhost> <1052826556.3ec0dbbc1d993@netmail.pipex.net> <20030513130257.78ab1a2e.akpm@digeo.com>
In-Reply-To: <20030513130257.78ab1a2e.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: PIPEX NetMail 2.2.0-pre13
X-PIPEX-username: aozw65%dsl.pipex.com
X-Originating-IP: 81.86.202.62
X-Usage: Use of PIPEX NetMail is subject to the PIPEX Terms and Conditions of use
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Andrew Morton <akpm@digeo.com>:

> > - Add ability to restrict the the default CPU affinity mask so that 
> >  sys_setaffinity() can be used to implement exclusive access to a CPU.
> 
> Why is this useful?

I forgot to add that the result is the rough equivalent of Digital UNIX's psets
and Irix's sysmp for my prurposes at least.


