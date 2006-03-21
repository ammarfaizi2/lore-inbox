Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWCUWzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWCUWzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWCUWzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:55:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26316 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965139AbWCUWzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:55:42 -0500
Subject: Re: "Low-latecny patch for ARM"
From: Lee Revell <rlrevell@joe-job.com>
To: ragin shah <shahragin1@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9597aec10603200258k59b08f7ex2b8b307d4d000c2f@mail.gmail.com>
References: <9597aec10603200258k59b08f7ex2b8b307d4d000c2f@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 17:55:35 -0500
Message-Id: <1142981736.4532.176.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 05:58 -0500, ragin shah wrote:
> Hi !
> I m student.
> I want to apply low-latency patch to kernel 2.4.26  for ARM processor.
> I applied Andrew Morton's low latency patch of 2.4.25kernel to 2.4.26
> kernel. I made some changes for '.config' section  to apply it
> correctly to ARM. Can anybody tell me whether i m right or wrong ? It
> is not giving any error while applying patch.
> Second thing,
> Can anybody please tell me how to measure scheduler latency for kernel
> on ARM after applying low-latency patch to measure kernel's
> responsiveness?
> Thanks in advance!

Use 2.6 with the -rt kernel patch, 2.4 and the low latency patch are
ancient history.

Lee

