Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264397AbTLKXAv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264401AbTLKXAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:00:51 -0500
Received: from p508B53A2.dip.t-dialin.net ([80.139.83.162]:57811 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S264397AbTLKXAu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:00:50 -0500
Date: Thu, 11 Dec 2003 23:58:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.24-pre1: ask for CONFIG_INDYDOG only on mips
Message-ID: <20031211225819.GA20373@linux-mips.org>
References: <Pine.LNX.4.44.0312101417080.1546-100000@logos.cnet> <20031210204628.GA9103@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031210204628.GA9103@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:46:28PM +0100, Adrian Bunk wrote:

> A dependency on a possibly undefined variable doesn't work with the 2.4 
> config system, and "make oldconfig" asks me on i386 for CONFIG_INDYDOG.

Applied - I hpe that's that last one of this kind lurking somewhere ...

  Ralf
