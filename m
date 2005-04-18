Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVDRHGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVDRHGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 03:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVDRHGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 03:06:47 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:18638 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261847AbVDRHGq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 03:06:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YGBBxq0kM97wRAx2ayaCg0VhODAgebmMetJhXCMPBxuuAyb992vEfR1Lvp/+xlyLlS2tBGouvhui6fv4gA7xlkUUOWj+gXPIlxnFr3QWAsqcNYYD3PjIAtCRrIunY0+gTWFQy66c2wG6tc4mR8nIoZgWUKHLWFjNRLDHnUei7FE=
Message-ID: <68b6a2bc050418000619a552de@mail.gmail.com>
Date: Mon, 18 Apr 2005 10:06:45 +0300
From: Ehud Shabtai <eshabtai.lkml@gmail.com>
Reply-To: Ehud Shabtai <eshabtai.lkml@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Need some help to debug a freeze on 2.6.11
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running Linux on my laptop and it sometimes freezes (about once a
week). The only thing which seems to work when it's stuck is SysRq (I
can reboot with SysRq+O), however, I'm in X and I don't have a serial
port on my laptop so I can't see any of the outputs of the SysRq
options.

After a reboot I don't see anything in my logs about the crash.

Can anyone suggest how to get some information about my freeze?
