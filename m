Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbUBEUYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUBEUYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:24:15 -0500
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:57533 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266422AbUBEUYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:24:05 -0500
From: Murilo Pontes <murilo_pontes@yahoo.com.br>
To: linux-kernel@vger.kernel.org
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 17:24:27 +0000
User-Agent: KMail/1.6
References: <200402041820.39742.wnelsonjr@comcast.net>
In-Reply-To: <200402041820.39742.wnelsonjr@comcast.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402051517.37466.murilo_pontes@yahoo.com.br>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have same problems since of 2.6.0, now I running 2.6.2 stock kernel
I run XFree86-4.3.0 and still with problems, anyone try XFree86-4.4.0 devel snapshots???

I try kernel with/without  preempty/acpi/apic make all possibilities, 
then may be error is not in kernel, but in XFree86-4.3.0 which not support big changes in input system
of 2.6.x, I tried compile XFree86 with linux-2.6.{0,1,2} kernel headers was 100% fail, sounds binary 
and source incompatibilites,  


Thanks in advance
