Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbTFSGLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265627AbTFSGLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:11:20 -0400
Received: from palrel12.hp.com ([156.153.255.237]:11448 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265626AbTFSGLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:11:19 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.22348.748334.416581@napali.hpl.hp.com>
Date: Wed, 18 Jun 2003 23:25:16 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: common name for the kernel DSO
In-Reply-To: <bcrkiq$dta$1@cesium.transmeta.com>
References: <16112.47509.643668.116939@napali.hpl.hp.com>
	<bcrkiq$dta$1@cesium.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 18 Jun 2003 23:18:02 -0700, "H. Peter Anvin" <hpa@zytor.com> said:

  HPA> It's a pretty ugly name, quite frankly, since it doesn't explain what
  HPA> it is a gate from or to.  linux-syscall.so.1 or linux-kernel.so.1
  HPA> would make a lot more sense.

Umh, it does say _linux_-gate, so I think it's pretty
self-explanatory.  I considered linux-kernel.so, but think it would
cause a lot of confusion vis-a-vis, say, kernel32.dll (I didn't write
that, did I??).  I'm not terribly fond of linux-syscall, but I could
live with it.

	--david
