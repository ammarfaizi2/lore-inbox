Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUGSGuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUGSGuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 02:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUGSGuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 02:50:15 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:9662 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264734AbUGSGuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 02:50:12 -0400
Date: Sun, 18 Jul 2004 23:47:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: solar@openwall.com, tigran@aivazian.fsnet.co.uk, alan@redhat.com,
       marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-Id: <20040718234726.77071830.pj@sgi.com>
In-Reply-To: <20040719045403.GA8212@alpha.home.local>
References: <20040707234852.GA8297@openwall.com>
	<Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
	<20040718125925.GA20133@openwall.com>
	<20040718212721.GC1545@alpha.home.local>
	<20040718161549.5c61d4a9.pj@sgi.com>
	<20040719045403.GA8212@alpha.home.local>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy writes:
> new process replaces the shell with the same pid.
> ... I'm afraid I'll have to test it.

True - same pid - good point.  Yup - testing is in order.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
