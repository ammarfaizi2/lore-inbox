Return-Path: <linux-kernel-owner+w=401wt.eu-S933161AbWLaNSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbWLaNSi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 08:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbWLaNSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 08:18:38 -0500
Received: from il.qumranet.com ([62.219.232.206]:50197 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933161AbWLaNSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 08:18:38 -0500
Message-ID: <4597B8AB.6040504@qumranet.com>
Date: Sun, 31 Dec 2006 15:18:35 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel <kvm-devel@lists.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] KVM: Miscellaneous stabilization fixes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A trio of fixes for miscellaneous problems, that don't affect usage 
under normal .configs and usage.  However they do need fixing.

-- 
error compiling committee.c: too many arguments to function

