Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264672AbTFQLha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 07:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264674AbTFQLha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 07:37:30 -0400
Received: from main.gmane.org ([80.91.224.249]:52352 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264672AbTFQLh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 07:37:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: krause@sdbk.de (Sebastian D.B. Krause)
Subject: Re: LD error building 2.5.71-bk2
Date: Tue, 17 Jun 2003 13:38:45 +0200
Message-ID: <874r2pdjcq@sdbk.de>
References: <Pine.LNX.4.44.0306170730040.27006-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:4tR43AduHVWH9hxatSzTPKJ0Okw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> wrote:
> net/built-in.o(.init.text+0x20b): In function `flow_cache_init':
> : undefined reference to `register_cpu_notifier'
> make: *** [.tmp_vmlinux1] Error 1

http://groups.google.com/groups?q=2.5.71+undefined+reference+register_cpu_notifier

