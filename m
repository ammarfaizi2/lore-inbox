Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTEGPWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264051AbTEGPWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:22:03 -0400
Received: from s-smtp-osl-01.bluecom.no ([62.101.193.35]:42707 "EHLO
	s-smtp-osl-01.bluecom.no") by vger.kernel.org with ESMTP
	id S264047AbTEGPWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:22:01 -0400
Subject: Re: The disappearing sys_call_table export.
From: petter wahlman <petter@bluezone.no>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1052321673.3727.737.camel@badeip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 May 2003 17:34:33 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
It seems like nobody belives that there are any technically valid
reasons for hooking system calls, but how should e.g anti virus
on-access scanners intercept syscalls?
Preloading libraries, ptracing init, patching g/libc, etc. are
obviously not the way to go.


-p.


