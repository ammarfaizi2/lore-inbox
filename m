Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbTEMJpX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 05:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTEMJpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 05:45:23 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:25835 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263444AbTEMJpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 05:45:22 -0400
Date: Tue, 13 May 2003 05:52:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200305130556_MC3-1-389D-DEBF@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> cat >/sbin/swapoff
> #!/bin/sh
> /sbin/swapoff.real
> /sbin/wipeswap
> ^D
> chmod +x /sbin/swapoff

  OK...

 # rpm --freshen mount-2.11n-12.rpm


   swapoff get silently replaced AFAICT.
