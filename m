Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbULYNz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbULYNz1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 08:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbULYNz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 08:55:26 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:17915 "EHLO
	mta05-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261509AbULYNzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 08:55:09 -0500
Message-ID: <41CD7EB3.4040704@gentoo.org>
Date: Sat, 25 Dec 2004 14:52:35 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.10-ck1
References: <200412250800_MC3-1-91AD-1E8B@compuserve.com>
In-Reply-To: <200412250800_MC3-1-91AD-1E8B@compuserve.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>   So 2.6.10 won't build without swap enabled?
> 
>   This was a known problem; how did it get out the door without that fix?

I don't think Con's fix is needed. Andrew merged an alternative fix at the 
last minute:

http://linux.bkbits.net:8080/linux-2.6/cset@1.2181

Daniel
