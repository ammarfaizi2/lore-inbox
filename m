Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268452AbUJPSZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbUJPSZu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 14:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268544AbUJPSZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 14:25:50 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:60683 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S268452AbUJPSZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 14:25:49 -0400
Date: Sat, 16 Oct 2004 20:25:44 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: David Schwartz <davids@webmaster.com>
Cc: mark@mark.mielke.cc,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041016182544.GC3379@pclin040.win.tue.nl>
References: <20041016043540.GA17514@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOELCPAAA.davids@webmaster.com>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : kweetal.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 09:58:38PM -0700, David Schwartz wrote:

> Linux's behavior is correct in the literal sense that it is doing something
> that is allowed. It's incorrect in the sense that it's sub-optimal.

"Allowed" by whom? By you?
