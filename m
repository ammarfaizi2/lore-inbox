Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbTDOBxJ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTDOBxJ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:53:09 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:6841 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264063AbTDOBxF (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 21:53:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ck5
Date: Tue, 15 Apr 2003 12:06:46 +1000
User-Agent: KMail/1.5.1
References: <3E96D711.70404@comcast.net> <1050370913.1933.6.camel@athena.fprintf.net>
In-Reply-To: <1050370913.1933.6.camel@athena.fprintf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304151206.46443.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 11:41, Daniel Gryniewicz wrote:
> I also have had a problem with ck5.  I've been using the ckX kernel for
> a while now, and they're great kernels.  ck4 was absolutely solid.  I've
> been following the interactiveness changes in 2.5, although I don't use
> it, with some interest, so I was really happy when you announced them in
> ck5.  However, it broke my Evolution.  In large folders (such as LKML),
> the current message jumps around randomly umong the unread messages when
> I try and select the next unread message.  This does not happen with ck4
> on an otherwise unchanged system (I use gentoo 1.4).  I remember
> information about 2.5 breaking Evolution, but that was a long time
> before these interactive fixes.  Here are my versions.  If there's
> anything else you want, let me know.

Yes sorry it's ck5's fault, it's b0rken. Use ck6 which is on the website now 
called ck6pre_2416030413_2.4.20.patch.bz2 It doesn't have the mem leak in ck5 
and has the interactivity patch removed. Ignore the pre name it's going to be 
renamed when I update my website et al. This should be as stable as ck4.

Con
