Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVFUUDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVFUUDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbVFUUDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:03:24 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:13735 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S261835AbVFUUDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:03:12 -0400
Message-ID: <39281.62.38.143.212.1119384443.squirrel@webmail.wired-net.gr>
In-Reply-To: <20050621125243.GA7139@wohnheim.fh-wedel.de>
References: <50773.62.38.141.127.1119357138.squirrel@webmail.wired-net.gr>
    <20050621125243.GA7139@wohnheim.fh-wedel.de>
Date: Tue, 21 Jun 2005 23:07:23 +0300 (EEST)
Subject: Re: 2.6 sendfile
From: nanakos@wired-net.gr
To: =?iso-8859-7?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: nanakos@wired-net.gr, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very interesting patches,but what i need to is a pacth or some points so i
can change the existing source code according to my needs.Can someone help
me on that?
The existing sendfile system call copies data from a file descriptor to a
socket descriptor.I have already a program that i have to port that uses
the sendfile syscall from 2.4.x series kernels.In 2.6.x doesnt work.What
are the minimal changes that have to be done so i can use again the
syscall in 2.6.x kernel's???


Thanks in advance.

