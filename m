Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUHTRvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUHTRvQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268455AbUHTRvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:51:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53153 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S268448AbUHTRvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:51:14 -0400
To: Andrew Morton <akpm@osdl.org>
cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/14] kexec for 2.6.8.1-mm2
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 11:50:00 -0600
Message-ID: <m18yc97l87.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here come my set of kexec patches against 2.6.8.1-mm2

This is everything except the handful that look too
experimental to be generally safe, or useful.

Eric

