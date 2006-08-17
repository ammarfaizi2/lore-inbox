Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbWHQFsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbWHQFsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWHQFsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:48:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:31479 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932443AbWHQFsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:48:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pB1/QLi9Ey+VsAO3FXDdc8KQOpKdroAO/dLeaeekoRclLpJCwgyC2ELpsTZHsBXa4Fss92J0Mi1oGw5zV4ik4vYxO3XymuUExxXdV7pVfQScL0xGrnlfXOO4YUYGsYRKd3pmeNX3TH1VEiZpgi5CpHbptaayvey0cZhdigJYmDU=
Message-ID: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
Date: Wed, 16 Aug 2006 22:48:36 -0700
From: "Anonymous User" <anonymouslinuxuser@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: GPL Violation?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I work for a company that will be developing an embedded Linux based
consumer electronic device.

I believe that new kernel modules will be written to support I/O
peripherals and perhaps other things.  I don't know the details right
now.  What I am trying to do is get an idea of what requirements there
are to make the source code available under the GPL.

I suspect the company will try to get away with releasing as little as
possible.  I don't know much about the GPL or Linux kernel internals,
but I want to encourage the company I work for to give back to the
community.

I understand that modifications to GPL code must be released under the
GPL.  So if they tweak a scheduler implementation, this must be
released.  What if a new driver is written to support a custom piece
of hardware?  Yes, the driver was written to work with the Linux
kernel, but it isn't based off any existing piece of code.

I'm posting anonymously because the company probably wouldn't want me
discussing this at all  :(

-anonymouslinuxuser
