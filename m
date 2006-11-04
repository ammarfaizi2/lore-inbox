Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752819AbWKBNK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbWKBNK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbWKBNK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:10:56 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:58262 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1752819AbWKBNKz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:10:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=g5hcxm5j6cC2Jk973x2eb4dGY7z3q++JvGM+tS21Qq/vBe3cAPHPoFbnl3fXuZ1Bm2hIUjMLu2C4kVq6MjO4S1Zn9iEdCcpL5BYEiazkXimcM6yT0GnyNmq9S+56U8v6adAULHE8s6nprNX+QNXStgW+2DbN0aCJpzf7IAcQ0c0=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 2/6] Add display output class support
Date: Sat, 4 Nov 2006 21:10:37 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611042110.38189.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add display output class support

signed-off-by   Luming.yu@gmail.com
---

