Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbUAUN0V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 08:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUAUN0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 08:26:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:51926 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263303AbUAUN0V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 08:26:21 -0500
Subject: Re: OOPS: cdrecord -scanbus on benh 2.5 tree causes oops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stewart Smith <stewart@linux.org.au>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
In-Reply-To: <1074683884.2623.4.camel@willster>
References: <1074607152.21539.15.camel@willster>
	 <1074634670.739.24.camel@gaston>  <1074683884.2623.4.camel@willster>
Content-Type: text/plain
Message-Id: <1074691544.974.21.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Jan 2004 00:25:45 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Seems to be okay in your current tree (rsyned today). Although I just
> found a HFS related oops....

CC me, lkml and Roman Zippel (it's his version of HFS that is in my tree)

Ben.


