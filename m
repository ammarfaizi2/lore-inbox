Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264140AbTDJUTa (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 16:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTDJUTa (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 16:19:30 -0400
Received: from pop.gmx.de ([213.165.65.60]:62632 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264140AbTDJUT3 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 16:19:29 -0400
Message-ID: <3E95D488.60806@gmx.net>
Date: Thu, 10 Apr 2003 22:31:04 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Hermann Himmelbauer <dusty@violin.dyndns.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rtl8139 Problem/kernel panic (probably unrelated)
References: <200304102118.24350.dusty@violin.dyndns.org>
In-Reply-To: <200304102118.24350.dusty@violin.dyndns.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hermann Himmelbauer wrote:
> Hi,
> I have problems with my Ovis Link 10/100 PCI Network adapter (based on 
> RTL8139too)
> 
> Until yesterday the NIC worked flawlessly with Linux-2.4.19-SuSE (from SuSE 
> 8.1) and rtl8139too (driver version 0.9.26).

Have you tried upgrading your kernel to the current version from SuSE?
The version number should be like k_deflt-2.4.19-274, which also would
fix the ptrace problem.

Regards,
Carl-Daniel

-- 
http://www.hailfinger.org/

