Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267727AbUHEXFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267727AbUHEXFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267752AbUHEXFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:05:36 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:42909 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S267727AbUHEXF3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:05:29 -0400
Message-ID: <4112BCEE.10102@rtr.ca>
Date: Thu, 05 Aug 2004 19:04:14 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Tupshin Harper1 <tupshin@tupshin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev/hdl not showing up because of	fix-ide-probe-double-detection
 patch
References: <411013F7.7080800@tupshin.com> <4111651E.1040406@tupshin.com>	 <20040804224709.3c9be248.akpm@osdl.org> <1091720165.8041.4.camel@localhost.localdomain>
In-Reply-To: <1091720165.8041.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Two disks are not permitted to have the same serial number.

Sure they are.

But the combination of MODEL::SERIALNO is guaranteed to be unique.
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
