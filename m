Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUCJXWy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbUCJXVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:21:52 -0500
Received: from adsl173-178.dsl.uva.nl ([146.50.173.178]:42415 "EHLO
	hypnos.var.cx") by vger.kernel.org with ESMTP id S262258AbUCJXUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:20:17 -0500
Date: Thu, 11 Mar 2004 00:20:18 +0100
From: Frank v Waveren <fvw@var.cx>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: root@chaos.analogic.com, "Randy.Dunlap" <rddunlap@osdl.org>,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: (0 == foo), rather than (foo == 0)
Message-ID: <20040310232018.GA21922@var.cx>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos> <404F6375.3080500@blue-labs.org> <Pine.LNX.4.53.0403101416001.20251@chaos> <404F6D03.3030504@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404F6D03.3030504@blue-labs.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 02:31:15PM -0500, David Ford wrote:
> >high resolution screen, perhaps even 400 columns. If you are
> >sending mail to somebody, you need to make sure it fits on
> >their page, not your page.
> And you have no idea what size screen they have.  Some text users I know 
> like to keep their screens at 60 chars so they can fit more terms on 
> their desktop.  Others have 100+ columns.  Let the end user flow the 
> text according to their own wishes.
> 
> Basic concept in good content presentation, you provide the content and 
> style, let the reader render it according to their page 
> characteristics.  Don't try to force everyone into 640x480, 72 columns, 
> or a particular text size.

This is good design, however horribly incompatible with the current
state of email/news postings. Luckily, a solution that doesn't break
anything has been found: If you want your text wrapped by the MUA, use
format=flowed in the content type header. Read RFC 2646.

-- 
Frank v Waveren                                      Fingerprint: 9106 FD0D
fvw@[var.cx|stack.nl|dse.nl] ICQ#10074100               D6D9 3E7D FAF0 92D1
Public key: hkp://wwwkeys.pgp.net/8D54EB90              3931 90D6 8D54 EB90
