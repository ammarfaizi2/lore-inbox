Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTL2Txt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTL2Tvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:51:45 -0500
Received: from jabba.unm.edu ([64.106.76.6]:41170 "HELO jabba.unm.edu")
	by vger.kernel.org with SMTP id S264497AbTL2Tuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:50:37 -0500
To: linux-kernel@vger.kernel.org
Subject: a PCI enumeration configuration question
Date: Mon, 29 Dec 2003 12:50:34 -0700
From: jing@unm.edu
Cc: sheltraw@unm.edu
Message-ID: <1072727434.3ff0858abc1ff@webmail1.unm.edu>
X-Mailer: UNM WebMail v1.1.10 24-January-2003
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: 198.59.134.37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, guys,

How to effectively disable a PCI device so that the resources are not 
allocated to it? For example, is it possible for me to provide pci id at 
boot promt or somewhere else so that I can bypass the device, such as 
some usb controllers. I am using linux kernel 2.4.20.

Thanks in advance,

jing

