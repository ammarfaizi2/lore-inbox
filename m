Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTKUGzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 01:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbTKUGzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 01:55:54 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51873
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262319AbTKUGzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 01:55:53 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Nigel Cunningham <ncunningham@clear.net.nz>, Shaheed <srhaque@iee.org>
Subject: Re: Patrick's Test9 suspend code.
Date: Fri, 21 Nov 2003 00:46:32 -0600
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311201726.48097.srhaque@iee.org> <200311202233.09609.srhaque@iee.org> <1069368082.2239.66.camel@laptop-linux>
In-Reply-To: <1069368082.2239.66.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311210046.32588.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 November 2003 16:41, Nigel Cunningham wrote:

> Whenever I switch from testing a 2.4 kernel to testing 2.6, I do a clean
> boot for precisely this reason. I'd love it if I could just suspend 2.4,
> boot the new 2.6 kernel, see if it suspends properly (to a different
> swap, of course) and then resume the original 2.4 kernel. But doing so
> would only work if I mounted 2.6 entirely read only, which is not what
> you seem to be planning.

You could of course have two completely different sets of root and swap 
partitions, if you have the disk space.  (And either not sharing /home or 
unmount it before suspending...)

Assuming you have the disk space, of course. :)

Rob

