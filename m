Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTFCVFh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 17:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbTFCVFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 17:05:36 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:55561 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261308AbTFCVFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 17:05:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: "J.A. Magallon" <jamagallon@able.es>,
       Anders Karlsson <anders@trudheim.com>
Subject: Re: Linux 2.4.21-rc6
Date: Tue, 3 Jun 2003 23:18:13 +0200
User-Agent: KMail/1.5.2
Cc: Michael Frank <mflt1@micrologica.com.hk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>,
       LKML <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <1054663333.2066.5.camel@tor.trudheim.com> <20030603211207.GG3661@werewolf.able.es>
In-Reply-To: <20030603211207.GG3661@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306032318.14159.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 June 2003 23:12, J.A. Magallon wrote:

Hi J.A.,

> One vote in the opposite sense (I know, nobody uses plain rc6 ???)
> I am using a -jam kernel (-aa with some additional patches), and I did
> not notice anything. Dual PII box with 900 Mb, as buffers were filling
> memory, no stalls. Just a very small (less than half a second) jump in the
> cursor under gnome when the memory got full, and then smooth again.
> I use pointer-focus and was rapidly moving the pointer from window to
> window to change focus and response was ok. Launching an aterm was instant.
once again for you ;-)

-aa is using low latency elevator! Pauses/Stops are more less with it.

ciao, Marc

