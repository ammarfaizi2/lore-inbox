Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTLaTar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLaTar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:30:47 -0500
Received: from smtp01.web.de ([217.72.192.180]:19223 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265248AbTLaTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:30:42 -0500
Message-ID: <3FF323DF.5060708@web.de>
Date: Wed, 31 Dec 2003 20:30:39 +0100
From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <18PG9-4og-27@gated-at.bofh.it> <18TgF-QJ-7@gated-at.bofh.it> <18TJE-1qL-3@gated-at.bofh.it>
In-Reply-To: <18TJE-1qL-3@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rüdiger Klaehn wrote:
> Any help is appreciated. At the moment I am quite happy about what is 
> being logged, but I am not sure how to best expose this to the 
> interested user space processes. A device was the easiest way, and so 
> that is what I used. Other possibilities would be a file in /proc or 
> something completely different. I got the impression that dbus might be 
> useful for this, but I have no idea how to use it.

Maybe relayfs is suitable for this task: http://www.opersys.com/relayfs/

Regards,
René
