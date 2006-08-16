Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWHPDOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWHPDOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 23:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWHPDOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 23:14:35 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:18186 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750877AbWHPDOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 23:14:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bVKRaf+kk36iHYXdPeS4j2j7Xwz9/S263QpGaFcp3lfiVQKsxES7Zu19m3vOebZ/6Jc6vH5YawfGNvboFnq9RtjPi1RFQ54hGOtByo5GofMvc7CRm0aXA/lrnYG8SvGbtHFyTFlVg3P8nI5FiHj1qs6KgpIjs41aYOTZ+vgkFvM=
Message-ID: <af203d350608152014i475899cet53d21e07db42d4a2@mail.gmail.com>
Date: Tue, 15 Aug 2006 20:14:33 -0700
From: "Milton Mobley" <miltmobley@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: need source for lspci, lsusb, etc.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I am building kernels from kernel.org sources, and am having problems
detecting certain pci and usb devices (I didn't change the kernel code
much yet).
Where can I find the sources for programs that live in /sbin, /usr/sbin, etc.,
especially lspci, lsusb, lsmod?
