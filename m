Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSLJRrX>; Tue, 10 Dec 2002 12:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLJRrX>; Tue, 10 Dec 2002 12:47:23 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:38383 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S262824AbSLJRrW> convert rfc822-to-8bit; Tue, 10 Dec 2002 12:47:22 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Matt Young <wz6b@arrl.net>
Reply-To: wz6b@arrl.net
To: linux-kernel@vger.kernel.org
Subject: Expeiment with a simple boot?
Date: Tue, 10 Dec 2002 09:54:33 -0800
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200212100954.33462.wz6b@arrl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.5.50 is there a boot procedure such as:

Turn off DEVFS and INITRDFS then specify the root device with major and minor 
numbers in the linux command line, (using grub)
