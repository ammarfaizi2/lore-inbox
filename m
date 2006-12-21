Return-Path: <linux-kernel-owner+w=401wt.eu-S965180AbWLUJpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965180AbWLUJpM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965181AbWLUJpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:45:12 -0500
Received: from il.qumranet.com ([62.219.232.206]:50862 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965180AbWLUJpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:45:10 -0500
Message-ID: <458A57A4.9000807@qumranet.com>
Date: Thu, 21 Dec 2006 11:45:08 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: kvm-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/5] KVM: Updates
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various minor fixes to support more guest OSes, fix a bug in exporting 
MSRs to userspace, and version the API.

-- 
error compiling committee.c: too many arguments to function

