Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVAJEAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVAJEAw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 23:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVAJEAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 23:00:51 -0500
Received: from zamok.crans.org ([138.231.136.6]:34462 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262062AbVAJEAq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 23:00:46 -0500
From: Mathieu Segaud <Mathieu.Segaud@crans.org>
To: Mikado <mikado4vn@yahoo.com>
Cc: Breno Silva Pinto <breno@kalangolinux.org>, linux-kernel@vger.kernel.org
Subject: Re: patch to uselib()
References: <20050110035427.75727.qmail@web53701.mail.yahoo.com>
Date: Mon, 10 Jan 2005 05:00:37 +0100
In-Reply-To: <20050110035427.75727.qmail@web53701.mail.yahoo.com>
	(mikado4vn@yahoo.com's message of "Sun, 9 Jan 2005 19:54:27 -0800
	(PST)")
Message-ID: <87u0pq9bmi.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikado <mikado4vn@yahoo.com> disait dernièrement que :

> upgrade to 2.4.29rc1 or patch ur current kernel with
> grsecurity patch (www.grsecurity.net)

the grsecurity patch does _not_ solve this vulnerability as stated on
their web site. they point to another patch to be applied
independently from grsecurity 2.1.0 patch:
http://www.grsecurity.net/linux-2.6.10-secfix-200501071130.patch

Regards,

Mathieu Segaud

-- 
We could be way simpler if we didn't try to be so flexible.

	- Andrew Grover, ACPI maintainer on Linux-power.

