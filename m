Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVKJVlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVKJVlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVKJVlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:41:04 -0500
Received: from fafnir.oit.pdx.edu ([131.252.120.58]:39147 "EHLO
	fafnir.oit.pdx.edu") by vger.kernel.org with ESMTP id S932152AbVKJVlD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:41:03 -0500
Message-ID: <4373BE6F.9000407@pdx.edu>
Date: Thu, 10 Nov 2005 13:41:03 -0800
From: Dean Pierce <piercede@pdx.edu>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: vbetool message
References: <4372df1a.01ca7dfd.1286.2fa3@mx.gmail.com> <005e01c5e5ec$0d3ea8e0$0200a8c0@SweetHome>
In-Reply-To: <005e01c5e5ec$0d3ea8e0$0200a8c0@SweetHome>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=windows-1250
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using the program vbetool, it says "mmap /dev/mem: Permission
denied".  When I check dmesg, it says "program vbetool is using
MAP_PRIVATE, PROT_WRITE mmap of VM_RESERVER memory, which is deprecated.
 Please report this to linux-kernel@vger.kernel.org"

.. so thats what I did.

If you want any for information, I'd be glad to help.

   - DEAN
