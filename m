Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313799AbSDIHOF>; Tue, 9 Apr 2002 03:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313803AbSDIHOE>; Tue, 9 Apr 2002 03:14:04 -0400
Received: from violet.setuza.cz ([194.149.118.97]:59919 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313799AbSDIHOE>;
	Tue, 9 Apr 2002 03:14:04 -0400
Subject: RE: Documentation or software - bug?
From: Frank Schaefer <frank.schafer@setuza.cz>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0204062230370.6422-200000@dragon.pdx.osdl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Apr 2002 09:14:04 +0200
Message-Id: <1018336445.620.4.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-04-07 at 08:38, Randy.Dunlap wrote:
> 
> Hi,
> 
> Here's my conclusion/opinion.
> 
> All of the (networking) BOOLEAN parameters expect newlen (in the
> sysctl system call) to be sizeof(int), not 1, but (your) sysctl
> program executes the syscall with newlen = 1.
> 
 
> ---------- Forwarded message ----------
> 
> Hi there,
> 
> I try to set up a box without procfs, thus I've to set some kernel
> parameters using _sysctl().
> 
Hi,

I've figured out this already, but thanks for you'r time

Regards
Frank

