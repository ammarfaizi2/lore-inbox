Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWBDOaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWBDOaW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 09:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWBDOaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 09:30:22 -0500
Received: from main.gmane.org ([80.91.229.2]:42177 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932285AbWBDOaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 09:30:21 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: yipee <yipeeyipeeyipeeyipee@yahoo.com>
Subject: Re: changing physical page
Date: Sat, 4 Feb 2006 14:29:54 +0000 (UTC)
Message-ID: <loom.20060204T152816-726@post.gmane.org>
References: <loom.20060202T160457-366@post.gmane.org> <Pine.LNX.4.61.0602021711110.8796@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.69.73.167 (Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.1) Gecko/20060111 Firefox/1.5.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh <at> veritas.com> writes:

[snip]

> I'll assume that when you say "page owned by a user program", you're
> meaning a private page, not a shared file page mapped into the program.
> 
> If you're asking about what currently happens, the answer is "No".
> 
> If you're asking about what you can assume, the answer is "Yes".

So you are saying that the current kernel doesn't move these kind of pages? but
it may in future versions?


thanks,
y



