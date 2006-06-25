Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWFYGJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWFYGJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 02:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWFYGJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 02:09:22 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:28120 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751406AbWFYGJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 02:09:22 -0400
Date: Sun, 25 Jun 2006 02:03:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: I can cause kernel panic by using native alsa midi with
  2.6.17.1
To: Knut J Bjuland <knutjbj@online.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606250207_MC3-1-C35F-F5F8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <449B8A0D.60607@online.no>

On Fri, 23 Jun 2006 08:28:29 +0200, Knut J Bjuland wrote:

> ksymoops 2.4.9 on i686 2.6.17-1.2138_FC5smp.  Options used

Please do not run oops reports through ksymoops.  The recipient
can do that.  And report Fedora bugs to Fedora...

> Jun 21 21:04:53 knutjorgen kernel: eax: 00000044   ebx: f767a768   ecx: c06bcfd0
> Jun 21 21:04:53 knutjorgen kernel: esi: f767a768   edi: f56d67e8   ebp: f56d6760

You chopped off the end of the lines here and throughout the oops.
Word wrapping is OK, but truncation is not.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
