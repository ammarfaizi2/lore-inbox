Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268348AbUI2Mvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268348AbUI2Mvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUI2Mve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 08:51:34 -0400
Received: from twiddle.criticalpath.it ([192.92.105.100]:52991 "EHLO
	twiddle.syswiz.it") by vger.kernel.org with ESMTP id S268348AbUI2Mv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 08:51:28 -0400
Message-ID: <415AB021.70605@criticalpath.net>
Date: Wed, 29 Sep 2004 14:52:49 +0200
From: Andrea Carpani <andrea.carpani@criticalpath.net>
Reply-To: andrea.carpani@criticalpath.net
Organization: Critical Path
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040901
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Adaptec aic79xx driver status
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As of linux 2.6.8.1 the aic79xx driver included is version 1.3.11 which 
dates back to July 11, 2003.

On my Tyan B2881 the used scsi controller has a lot of problems: as soon 
as I try to transfer some data I get a frozen scsi subsystem and a dump 
in the syslog messages.

I hope to be able to solve these problems by using the new driver found 
at http://people.freebsd.org/~gibbs/linux/SRC/

My question is: why isn't the new version included in the main tree?

Thanks.

-- 

.a.c.
Andrea Carpani
<andrea.carpani@criticalpath.net>


