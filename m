Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271125AbTHLVc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271140AbTHLVc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:32:59 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:25265 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271125AbTHLVc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:32:58 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Tue, 12 Aug 2003 23:32:56 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 + Reiserfs + NFS oops
Message-Id: <20030812233256.21c80830.skraw@ithnet.com>
In-Reply-To: <200308121440.24983.lucasvr@gobolinux.org>
References: <200308121440.24983.lucasvr@gobolinux.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 14:40:24 -0300
Lucas Correia Villa Real <lucasvr@gobolinux.org> wrote:

> Hi,
> 
> I have been trying to export an reiserfs partition on NFS. I can mount it 
> remotely and even create files on it, but I always got a kernel oops when 
> trying to remove any file. I have also tryied to export another partition, 
> formatted as ext2 (but keeping my root fs as reiserfs), but the problem has 
> persisted.

Have you tried to compile your kernel with another compiler (i.e. not gcc 3.2.X) ?

Regards,
Stephan

