Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVIUPYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVIUPYp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 11:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbVIUPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 11:24:45 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:22988 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751061AbVIUPYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 11:24:44 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Xin Zhao <uszhaoxin@gmail.com>
Subject: Re: Is stack back trace possible if compiled with -fomit-frame-pointer?
Date: Wed, 21 Sep 2005 16:25:11 +0100
User-Agent: KMail/1.8.90
Cc: linux-kernel@vger.kernel.org
References: <4ae3c140509210737383422b3@mail.gmail.com>
In-Reply-To: <4ae3c140509210737383422b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211625.11342.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 15:37, Xin Zhao wrote:
> Also, I might want to know whether it is common case that linux apps
> are compiled with  -fomit-frame-pointer swtich?
>

Barring gentoo/LFS/DIY distros, where no such assertions can be made, the 
answer is probably "no". Most distros don't strip out a useful source of 
userspace debugging for the sake of 'speed'.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
