Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTJ1WmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTJ1WmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:42:15 -0500
Received: from main.gmane.org ([80.91.224.249]:40633 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261752AbTJ1WmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:42:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Floppy in 2.6
Date: Tue, 28 Oct 2003 23:42:12 +0100
Message-ID: <yw1xekwxx9vf.fsf@kth.se>
References: <20031028232054.1d452baa.news.receive@zoznam.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:3pfvIXZJvkT0VNAEe3QO3HL5Ssk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Krajcovic <news.receive@zoznam.sk> writes:

> In 2.4 there was the option for "normal floppy support" and I have the
> /dev/fd0 device for my floppy when I boot the old 2.4.22 kernel. So my
> question is: does the 2.6 kernel support normal floppy disks or not?
> And if it does, how do I enable this support in order to use my floppy
> drive.

It's there.  In menuconfig it's "Device Drivers" -> "Block devices" ->
"Normal floppy disk support".

Who uses floppy disks nowadays, anyway?

-- 
Måns Rullgård
mru@kth.se

