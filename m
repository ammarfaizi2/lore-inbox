Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVIYOik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVIYOik (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 10:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVIYOij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 10:38:39 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:57230 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751464AbVIYOij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 10:38:39 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: A pettiness question.
To: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@goodmis.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Vadim Lobanov <vlobanov@speakeasy.net>, Nick Warne <nick@linicks.net>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sun, 25 Sep 2005 16:38:27 +0200
References: <4PiLw-2yn-25@gated-at.bofh.it> <4Pj4M-3as-1@gated-at.bofh.it> <4PtnM-1oW-55@gated-at.bofh.it> <4Pynh-fp-1@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EJXe7-0000lD-Vw@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:

> Actually I prefer:
> 
> a += (x == '-'-'-'?'-'-'-':'/'/'/');

a += (x^'^'^'^'?'/'/'/':'-'-'-');

CNR
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
