Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUAWPNp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266584AbUAWPNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:13:45 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:24448 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S266582AbUAWPNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:13:43 -0500
Date: Fri, 23 Jan 2004 15:13:40 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: gcc 2.95.3
Message-ID: <20040123151340.B1130@beton.cybernet.src>
References: <20040123145048.B1082@beton.cybernet.src> <20040123100035.73bee41f.jeremy@kerneltrap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040123100035.73bee41f.jeremy@kerneltrap.org>; from jeremy@kerneltrap.org on Fri, Jan 23, 2004 at 10:00:35AM -0500
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 10:00:35AM -0500, Jeremy Andrews wrote:
> > Is it correct to issue "make bzImage modules modules_install"
> > or do I have to do make bzImage; make modules modules_install?
> > 
> > Is there any documentation where I can read answer to this question?
> 
> make help

Cool. I got to README :)

I read here "make sure you have gcc 2.95.3 available" - does it mean
my gcc-3.2.3 or gcc-3.2.2 is not suitable for kernel compiling?

Cl<
