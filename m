Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWEVSVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWEVSVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWEVSVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:21:44 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:18884 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1751116AbWEVSVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:21:43 -0400
Message-ID: <4472016F.6020102@keyaccess.nl>
Date: Mon, 22 May 2006 20:22:39 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Con Kolivas <kernel@kolivas.org>, Lee Revell <rlrevell@joe-job.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl>	 <1148247047.20472.78.camel@mindpipe> <44710162.3070406@keyaccess.nl>	 <200605221033.49153.kernel@kolivas.org> <1148264043.7643.15.camel@homer>
In-Reply-To: <1148264043.7643.15.camel@homer>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

> On Mon, 2006-05-22 at 10:33 +1000, Con Kolivas wrote:

>> This close to 2.6.17 the safest thing we can and should do is simply back out 
>> the patch.
> 
> Agreed.  That will reinstate terminal starvation in some cases, but
> those cases are much less common than this one.

Ah okay. I see that's already done even. Thanks for the quick responses.

Rene.

