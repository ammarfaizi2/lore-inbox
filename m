Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTKCUVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTKCUVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:21:36 -0500
Received: from main.gmane.org ([80.91.224.249]:16023 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263189AbTKCUVd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:21:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: how to restart userland?
Date: Mon, 03 Nov 2003 21:21:30 +0100
Message-ID: <yw1xn0bdnqyd.fsf@kth.se>
References: <20031103193940.GA16820@louise.pinerecords.com> <200311032003.hA3K3tgv017273@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:nISHJfuMcf4T3GFdDtzI93XBflA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

>> Would anyone know of a proven way to completely restart the userland
>> of a Linux system?
>
> This would be distinct from 'shutdown -r' how?  Is there a reason you
> want to "completely" restart userland and *not* reboot (for instance,
> wanting to keep existing mounts, etc)?

Perhaps save some time.  Some systems have notoriously slow BIOS.

-- 
Måns Rullgård
mru@kth.se

