Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTKCPwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 10:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbTKCPwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 10:52:16 -0500
Received: from main.gmane.org ([80.91.224.249]:54675 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262056AbTKCPwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 10:52:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: NFS on 2.6.0-test9
Date: Mon, 03 Nov 2003 16:52:11 +0100
Message-ID: <yw1xism1phzo.fsf@kth.se>
References: <200311031342.35857.newsregister@driscollnewsletter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:XmkvsfWxBtlrcp+AEZRLlGzM5dE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Driscoll <newsregister@driscollnewsletter.com> writes:

> On a kernel 2.6.0-test9 as an NFS client I am having trouble transferring
> data to and from NFS servers. It it extraordinarily slow.  I receive the
> following information in dmesg:
>
> nfs warning: mount version older than kernel

I see that one, too.  Apart from that, it appears to work.  Try the
tcp option, and see if it helps.

-- 
Måns Rullgård
mru@kth.se

