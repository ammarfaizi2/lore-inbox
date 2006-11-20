Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932722AbWKTJsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbWKTJsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 04:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934038AbWKTJsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 04:48:50 -0500
Received: from il.qumranet.com ([62.219.232.206]:55700 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932722AbWKTJsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 04:48:50 -0500
Message-ID: <45617A00.5040303@qumranet.com>
Date: Mon, 20 Nov 2006 11:48:48 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Yaniv Kamay <yaniv.kamay@qumranet.com>
Subject: [PATCH 0/3] KVM: Assorted minor fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patchset fixes some minor kvm issues, mostly found while 
adding AMD support.

-- 
error compiling committee.c: too many arguments to function

