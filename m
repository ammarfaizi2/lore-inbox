Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbTDIKYj (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 06:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbTDIKYj (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 06:24:39 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:37344 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262985AbTDIKYi (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 06:24:38 -0400
Message-ID: <3E93F7A4.2050406@ntlworld.com>
Date: Wed, 09 Apr 2003 11:36:20 +0100
From: ael <law_ence.dev@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-gb, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI_DEVICE_ID_TTI_HPT372N undeclared: 2.4.21-pre7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.21-pre7 fails to compile with CONFIG_BLK_DEV_HPT366=y .


In file included from hpt366.c:70:
hpt366.h:517: `PCI_DEVICE_ID_TTI_HPT372N' undeclared here (not in a function)

ael

