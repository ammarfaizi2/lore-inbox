Return-Path: <linux-kernel-owner+w=401wt.eu-S932448AbXAGJSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbXAGJSG (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbXAGJSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:18:06 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:50219 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbXAGJSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:18:05 -0500
Message-ID: <45A0BA6D.2090706@gmail.com>
Date: Sun, 07 Jan 2007 10:16:29 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Amit Choudhary <amit2030@yahoo.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DISCUSS] Making system calls more portable.
References: <647618.57006.qm@web55614.mail.re4.yahoo.com>
In-Reply-To: <647618.57006.qm@web55614.mail.re4.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07/2007 10:07 AM, Amit Choudhary wrote:

> However, people may say that, implementing custom system calls is not
> advocated by linux. And I think it is not advocated precisely because
> of this reason that they are not portable.

True I guess. But do you want to live in a software environment where as 
a matter of course every distribution out there puts its "value-add" in 
custom system calls and creating a $DISTRIBUTION-only userspace? After 
all, if nothing uses their shiny new custom syscall, they might as well 
not add it. This would fragment Linux quite horribly and IMO cases where 
this happens should be _dis_ couraged, not encouraged by making it less 
problematic to survive the resulting mess.

Rene.
