Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSAUQnW>; Mon, 21 Jan 2002 11:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSAUQnD>; Mon, 21 Jan 2002 11:43:03 -0500
Received: from dsl081-242-114.sfo1.dsl.speakeasy.net ([64.81.242.114]:41088
	"EHLO drscience.sciencething.org") by vger.kernel.org with ESMTP
	id <S287386AbSAUQnA>; Mon, 21 Jan 2002 11:43:00 -0500
User-Agent: Microsoft-Entourage/10.0.0.1309
Date: Mon, 21 Jan 2002 08:39:27 -0800
Subject: UVFS Yet another user space filesystem kit.
From: Britt Park <britt@drscience.sciencething.org>
To: <linux-kernel@vger.kernel.org>
Message-ID: <B871843F.200D%britt@sciencething.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to announce the availability of version 0.1 of UVFS, yet
another user space filesystem kit.  UVFS provide an interface to almost all
kernel VFS methods in user space with acceptable overhead.  It comes with a
sample in memory filesystem as documentation.

As far as I can determine UVFS is quite robust but I would love to have some
independent confirmation of that.  I would also be delighted if someone more
familiar with the linux VFS than I, were to give the code a once-over.

The current version of UVFS only supports a single instance of a given
filesystem type.  That will be addressed in the next public release.

UVFS can be found at http://www.sciencething.org/geekthings/index.html .

Britt Park

