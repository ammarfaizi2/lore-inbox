Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUKMXd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUKMXd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUKMXbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:31:43 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:14567 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261206AbUKMXaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:30:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=TqIs+kDKJ+THBoOZZwfj81nQ6At/GCX+R2Dl1B+9V5zHfCKZsk4og6qn4vQML424lVNbt3VM9+2/hCb63Uge5Wb5e8hnNEDZ+m+7mGbu+cK5V2f+kzC6cqp/KRFnP6tKzDryfcvJ3Kuea/JljHVsYCmL/5oubTss2Y7vzPW0Aak=
Message-ID: <bb113b9a04111315303baaa119@mail.gmail.com>
Date: Sat, 13 Nov 2004 15:30:14 -0800
From: Soumen Sarkar <soumen.sarkar@gmail.com>
Reply-To: Soumen Sarkar <soumen.sarkar@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22 vs 2.4.24 question
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question on Linux kernel 2.4.22 vs 2.4.24. I am observing that the
machine running 2.4.22 kernel reports more file descriptor in use by:

cat /proc/sys/fs/file-nr

compared to machine running 2.4.24 kernel. It is my belief that both of these
systems are used in roughly similar manner.

Would like to know if this observation could be attributed to kernel version
difference.

Thanks in advance,
Soumen
