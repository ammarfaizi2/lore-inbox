Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTFJRVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 13:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTFJRVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 13:21:04 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:39372 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S263643AbTFJRUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 13:20:55 -0400
Message-ID: <3EE66C86.8090708@free.fr>
Date: Wed, 11 Jun 2003 01:40:54 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosati wrote:

 >The main reason I didnt want to merge it was due to its size. Its just 
 >too big.

 >> Please stop leading me along. Will you EVER merge it?

 >Yes, I want to, and will merge it. In 2.4.23-pre.

This kind of mails and sentence makes you lost your credibility :
	1) You said that ACPI will be merged in 2.4.22-pre,
	2) For many people ACPI (and aic7xxx) is top priority for 2.4 kernel 
(see various post including alan). The reason being that most laptop are 
unusable nowadays without ACPI,
	3) You do not explicitely says what you plan for 2.4.22...

So, for stupid people like me, could you take a little time to explains 
the dummy's what are your views about what is top priority for kernel 
and for what reasons?

I would personnally suggest that you classify the things using the 
following filter :
	a) Server (SMP, SCSI, RAID, journaling filesystems, ...),
	b) laptop (ACPI, CPUFREQ, Software suspend, IDE power save,...),
	c) desktop (File system efficiency, new hardware support,...),
	d) all systems

Or maybe you simply think that software engineering is a kind of black 
art that is too hard to understand for average people...


-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

