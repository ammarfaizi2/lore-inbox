Return-Path: <linux-kernel-owner+w=401wt.eu-S933165AbWLaM5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbWLaM5q (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbWLaM5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:57:46 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57107 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933165AbWLaM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:57:45 -0500
Date: Sun, 31 Dec 2006 13:56:55 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Miller <davem@davemloft.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sparc@vger.kernel.org
Subject: Re: openpromfs issue
Message-ID: <Pine.LNX.4.61.0612311352410.32449@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,


in http://lkml.org/lkml/2006/5/15/128 I reported a problem with 
openpromfs showing both CPUs under the same node name. As I looked today 
into /proc/openpromfs - running 2.6.18-1.2798.al3.1smp now - this issue 
is fixed.
Any details about this - can you point me to a linux-sparc archived 
message or the git changeset?


Thanks,
	-`J'
-- 
