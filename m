Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbVIIUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbVIIUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030455AbVIIUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 16:25:26 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:13025 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1030437AbVIIUZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 16:25:25 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: query_modules syscall gone? Any replacement?
To: iSteve <isteve@rulez.cz>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 09 Sep 2005 22:25:08 +0200
References: <4KSFY-2pO-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1EDpQq-0000iV-Oe@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve <isteve@rulez.cz> wrote:

>   May I then ask, why is the query_module syscall gone? And more
> importantly, what replaces it, if anything?

I don't know query_module, but ls -laR /sys/module might do the job.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
