Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbTJPE4V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 00:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTJPE4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 00:56:20 -0400
Received: from rth.ninka.net ([216.101.162.244]:56706 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262739AbTJPE4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 00:56:19 -0400
Date: Wed, 15 Oct 2003 21:56:16 -0700
From: "David S. Miller" <davem@redhat.com>
To: Veeriah Vijay-A19819 <vijaysv@motorola.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: Active TCP connection  aborts  for no reason
Message-Id: <20031015215616.79b5fb23.davem@redhat.com>
In-Reply-To: <EDFB2B1ED0A1D7118A0A00065BF2490D4B6234@il06exm13.corp.mot.com>
References: <EDFB2B1ED0A1D7118A0A00065BF2490D4B6234@il06exm13.corp.mot.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 17:32:29 -0500
Veeriah Vijay-A19819 <vijaysv@motorola.com> wrote:

> I am using 2.4.7 kernel ...

There have been hundreds of fixes to the TCP code since 2.4.7, so it's
basically a waste of time for anyone to try and analyze your report
until you try and reproduce it with current generation 2.4.x kernels.
2.4.22 would be fine.

This applies to all of the reports you posted today.
