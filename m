Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263050AbUK0BoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263050AbUK0BoA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUK0Bkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:40:31 -0500
Received: from neopsis.com ([213.239.204.14]:63636 "EHLO
	matterhorn.neopsis.com") by vger.kernel.org with ESMTP
	id S263053AbUK0BhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 20:37:12 -0500
Message-ID: <41A7DAEF.9030503@dbservice.com>
Date: Sat, 27 Nov 2004 02:39:59 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 36/51: Highlevel I/O routines.
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101298276.5805.334.camel@desktop.cunninghams> <20041125233629.GC2909@elf.ucw.cz>
In-Reply-To: <20041125233629.GC2909@elf.ucw.cz>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>+extern volatile int suspend_io_time[2][2];
> 
> 
> Why volatile?

I think Linus doesn't like this keyword very much. And I
also think he said it should not be used.

tom
