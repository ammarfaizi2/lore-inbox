Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVIGMCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVIGMCl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 08:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIGMCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 08:02:41 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:30141 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S932124AbVIGMCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 08:02:40 -0400
From: Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org>
Subject: Re: kbuild & C++
To: Budde@vger.kernel.org, Marco <budde@telos.de>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 07 Sep 2005 14:02:30 +0200
References: <4JJOt-77X-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ECydL-0000oM-GC@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Budde, Marco <budde@telos.de> wrote:

> for one of our customers I have to port a Windows driver to
> Linux. Large parts of the driver's backend code consists of
> C++.
> 
> How can I compile this code with kbuild? The C++ support
> (I have tested with 2.6.11) of kbuild seems to be incomplete /
> not working.

Maybe this can help: http://en.wikipedia.org/wiki/Cfront
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
