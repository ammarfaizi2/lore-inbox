Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161991AbWKPLXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161991AbWKPLXP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031160AbWKPLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:23:14 -0500
Received: from web27402.mail.ukl.yahoo.com ([217.146.177.178]:61560 "HELO
	web27402.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1031159AbWKPLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:23:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2wx3SRfanOUBxPx3zKOhfFcusomKoX9xSSVIk6n8O38PzwMkYPAVrSCe0poexQo6d0JOFkyb/cxjweclsVkwTQPImTBPVwC3HwGVw50369iT/W8Bo6tsZViInFdRG738LQZ2u/Fz/b+DnS/8tD3/99qhBmhA8jYzVhoeDyp8kSI=  ;
Message-ID: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
Date: Thu, 16 Nov 2006 11:23:12 +0000 (GMT)
From: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
Subject: diabling interrupts on pentium 4 processor
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    How to disable interrupts on pentium 4 (or any
i386)
    machine?

     I tried to include "cli" instruction in a kernel
module. But got runtime error.

Thanks in advance.



		
___________________________________________________________ 
Try the all-new Yahoo! Mail. "The New Version is radically easier to use" – The Wall Street Journal 
http://uk.docs.yahoo.com/nowyoucan.html
