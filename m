Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbUJ0Rhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbUJ0Rhu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUJ0RfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:35:24 -0400
Received: from main.gmane.org ([80.91.229.2]:8839 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262548AbUJ0R1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:27:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: [OT] Re: The naming wars continue...
Date: Wed, 27 Oct 2004 19:27:04 +0200
Message-ID: <yw1xu0sgnkbb.fsf@mru.ath.cx>
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041026203137.GB10119@thundrix.ch>
 <417F2251.7010404@zytor.com>
 <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041027154828.GA21160@thundrix.ch>
 <Pine.LNX.4.60.0410271803470.614@alpha.polcom.net>
 <20041027161402.GC21160@thundrix.ch>
 <Pine.LNX.4.60.0410271830430.614@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 154.80-202-166.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:zKMxA3unD0eJTTEU4MM23M3I8H4=
Cc: uclibc@uclibc.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> writes:

> 5. I am thinking of changing directory structure (and some other
> things) some more... For example placing every package in its own dir
> - like /apps/gcc/3.4.2/<install date>/{bin,lib,...} and placing

I've been placing things in /opt/package/version for quite a while.  I
use a perl script to set the *PATH environment variables to point at
whatever versions I choose for each package.  I patched aclocal (of
automake) to search in directories given by $ACLOCAL_PATH, but the
patch has been ignored for several years, so I'm not expecting it to
be picked up.

-- 
Måns Rullgård
mru@inprovide.com

