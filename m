Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTDJErp (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 00:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbTDJErp (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 00:47:45 -0400
Received: from [203.197.168.150] ([203.197.168.150]:22032 "HELO
	mailscanout256k.tataelxsi.co.in") by vger.kernel.org with SMTP
	id S263798AbTDJEro (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 00:47:44 -0400
Message-ID: <3E94FAB6.49465DC2@tataelxsi.co.in>
Date: Thu, 10 Apr 2003 10:31:42 +0530
From: "Prasanta Sadhukhan" <prasanta@tataelxsi.co.in>
X-Mailer: Mozilla 4.6 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: setting LAA in token ring
Content-Type: text/plain; charset=x-user-defined
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Our cardbus driver   supports LAA but when
we are giving this command 'ifconfig  tr0 hw tr 4000DEADBEEF' but we are
getting
SIOCSIFHWADDR: Invalid argument

Is there any prerequisites fot this command to be given?

Thanking you all
Prasanta



