Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbUCJXlQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUCJXlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:41:15 -0500
Received: from main.gmane.org ([80.91.224.249]:55532 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262884AbUCJXkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:40:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [OT] Re: (0 == foo), rather than (foo == 0)
Date: Thu, 11 Mar 2004 00:33:08 +0100
Message-ID: <yw1x7jxsxop7.fsf@kth.se>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org>
 <Pine.LNX.4.53.0403101324120.18709@chaos> <404F6375.3080500@blue-labs.org>
 <Pine.LNX.4.53.0403101416001.20251@chaos> <404F6D03.3030504@blue-labs.org>
 <20040310232018.GA21922@var.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-2480.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:SAWxgrdyAB2355F0ln/Sz0aOl0k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank v Waveren <fvw@var.cx> writes:

> This is good design, however horribly incompatible with the current
> state of email/news postings. Luckily, a solution that doesn't break
> anything has been found: If you want your text wrapped by the MUA, use
> format=flowed in the content type header. Read RFC 2646.

But don't do that if there's C (or other) code in the message.

-- 
Måns Rullgård
mru@kth.se

