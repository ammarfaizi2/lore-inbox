Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbUAWSz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 13:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266590AbUAWSz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 13:55:27 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:32007 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262746AbUAWSzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 13:55:22 -0500
Subject: Re: gcc 2.95.3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123151340.B1130@beton.cybernet.src>
References: <20040123145048.B1082@beton.cybernet.src>
	 <20040123100035.73bee41f.jeremy@kerneltrap.org>
	 <20040123151340.B1130@beton.cybernet.src>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1074884119.1544.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Fri, 23 Jan 2004 19:55:19 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 16:13, Karel Kulhavý wrote:
> On Fri, Jan 23, 2004 at 10:00:35AM -0500, Jeremy Andrews wrote:
> > > Is it correct to issue "make bzImage modules modules_install"
> > > or do I have to do make bzImage; make modules modules_install?
> > > 
> > > Is there any documentation where I can read answer to this question?
> > 
> > make help
> 
> Cool. I got to README :)
> 
> I read here "make sure you have gcc 2.95.3 available" - does it mean
> my gcc-3.2.3 or gcc-3.2.2 is not suitable for kernel compiling?

I've been compiling 2.5 and 2.6 kernels since gcc 3.3 with no problems.
In fact, there are patches on the -mm tree to help compiling with gcc
3.4 and 3.5.

I think the Documentation is a little bit updated ;-)

