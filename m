Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTELQ6w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTELQ6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:58:51 -0400
Received: from mail2.ewetel.de ([212.6.122.20]:20687 "EHLO mail2.ewetel.de")
	by vger.kernel.org with ESMTP id S262271AbTELQ6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:58:50 -0400
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030512164017$6c09@gated-at.bofh.it>
References: <20030512164017$6c09@gated-at.bofh.it>
Date: Mon, 12 May 2003 19:02:55 +0200
Message-Id: <E19FGhT-0000b1-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003 18:40:17 +0200, you wrote:

>   ...and on a related topic, if someone wrote a patch to optionally clear
> the swap area at swapoff would it ever be accepted?

What about doing it from userspace? :)

-- 
Ciao,
Pascal
