Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbULBTJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbULBTJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 14:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbULBTJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 14:09:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:3781 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261725AbULBTGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 14:06:40 -0500
Date: Thu, 2 Dec 2004 11:10:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Mock <kd6pag@qsl.net>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-Id: <20041202111040.432d2440.akpm@osdl.org>
In-Reply-To: <E1CZv5H-0001zG-00@penngrove.fdns.net>
References: <E1CZv5H-0001zG-00@penngrove.fdns.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Mock <kd6pag@qsl.net> wrote:
>
> The problem is with the 'sonypi' module, which i will document separately.

There have been recent sonypi patches, althought they're fairly
minor-looking.  But make sure that you're using the latest kernel. 
2.6.10-rc2 is ancient history ;)

