Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbUAPM3u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUAPM3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:29:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23439 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265403AbUAPM3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:29:48 -0500
Subject: Re: filesystem bug?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: tsuchiya@labs.fujitsu.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <4007537F.4070609@labs.fujitsu.com>
References: <4007537F.4070609@labs.fujitsu.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1074256175.4006.24.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jan 2004 12:29:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-01-16 at 02:59, Tsuchiya Yoshihiro wrote:

> I tried with /bin/zsh, and it seems you are right. The script
> is working fine for about 2 hours.

Thank you for checking.

> So I will try to find out about EIO(inode corruption) problem next.

OK.  Under exactly what circumstances have you seen this in the past, as
opposed to the other problem?  I have not been able to reproduce this
one so far.

Cheers, 
 Stephen

