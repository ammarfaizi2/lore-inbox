Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWCTK6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWCTK6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWCTK6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:58:36 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:25550 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932175AbWCTK6f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:58:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ox5phd6B9lbOXH2egcOryUeGawIfPC8c3Lop+OwJ6l/tA8CMCPVJAHbuIeILJS7ScY5MWrciv2DwSWeQjGlrrMQcLqAlXCs3vtopttIocKOh3Pn3Hx0/bYuNPQ3jjMVcQfieX71DYsV7BqwoicfLbMO2Txc6XzVEpvHU80bBkWM=
Message-ID: <9597aec10603200258k59b08f7ex2b8b307d4d000c2f@mail.gmail.com>
Date: Mon, 20 Mar 2006 05:58:34 -0500
From: "ragin shah" <shahragin1@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: "Low-latecny patch for ARM"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
I m student.
I want to apply low-latency patch to kernel 2.4.26  for ARM processor.
I applied Andrew Morton's low latency patch of 2.4.25kernel to 2.4.26
kernel. I made some changes for '.config' section  to apply it
correctly to ARM. Can anybody tell me whether i m right or wrong ? It
is not giving any error while applying patch.
Second thing,
Can anybody please tell me how to measure scheduler latency for kernel
on ARM after applying low-latency patch to measure kernel's
responsiveness?
Thanks in advance!
