Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTFVJ0U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 05:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTFVJ0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 05:26:20 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:17412 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264389AbTFVJ0T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 05:26:19 -0400
Date: Sun, 22 Jun 2003 02:40:46 -0700
From: Andrew Morton <akpm@digeo.com>
To: =?ISO-8859-1?B?UmVu6Q==?= Scharfe <l.s.r@web.de>
Cc: sfrench@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [CIFS] Fix compile warning for fs/cifs/cifsfs.c
Message-Id: <20030622024046.3be991a5.akpm@digeo.com>
In-Reply-To: <20030622111911.33c1d041.l.s.r@web.de>
References: <20030622111911.33c1d041.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 22 Jun 2003 09:40:24.0212 (UTC) FILETIME=[4E114D40:01C338A2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
>
> this patch fixes a compile warning about incompatible types in
>  fs/cifs/cifsfs.c in cifs_statfs().

oop, sorry.  I'll send that in, thanks. 
