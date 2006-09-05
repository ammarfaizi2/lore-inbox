Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWIEFg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWIEFg2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 01:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbWIEFg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 01:36:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41159 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965161AbWIEFg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 01:36:27 -0400
Date: Tue, 5 Sep 2006 14:39:24 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, oleg@tv-sign.ru,
       jdelvare@suse.de, acahalan@gmail.com, pj@sgi.com
Subject: Re: [PATCH] proc: readdir race fix
Message-Id: <20060905143924.af1130aa.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m14pvn3tam.fsf_-_@ebiederm.dsl.xmission.com>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
	<20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com>
	<m14pvn3tam.fsf_-_@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 21:07:29 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Thanks to KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> for
> providing the first fix, pointing this out and working on it.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

worked well with my (short) test set. and looks good.
Thank you.

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

