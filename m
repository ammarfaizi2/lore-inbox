Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316953AbSE1Ve4>; Tue, 28 May 2002 17:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSE1Vez>; Tue, 28 May 2002 17:34:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39150 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316953AbSE1Vex>; Tue, 28 May 2002 17:34:53 -0400
Subject: Re: PROBLEM: Atapi IDE CD/DVD Driver - Ooops, Unable to handle
	kernel NULL pointer dere....
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Barker <mbarker@dsl.pipex.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022620209.1368.17.camel@corona>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 23:37:59 +0100
Message-Id: <1022625479.4123.144.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 22:10, Michael Barker wrote:

> Currently running Redhat 7.2 (uname = 'Linux corona 2.4.7-10 #1 Thu Sep
> 6 16:46:36 EDT 2001 i686 unknown'). AMD 1600, Asus AV333 Motherboard,

Start by updating to the Red Hat 7.2 errata kernel from a few months
ago.
