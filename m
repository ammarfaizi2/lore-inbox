Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbUAHXzO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUAHXzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:55:13 -0500
Received: from bender.bawue.de ([193.7.176.20]:12750 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S264288AbUAHXzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:55:10 -0500
To: a.othieno@bluewin.ch (Arthur Othieno)
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1-rc3] Canonically reference files in
 Documentation/, Documentation/ part
In-Reply-To: <20040108221040.GB785@mars> (Arthur Othieno's message of "Thu,
 8 Jan 2004 23:10:40 +0100")
References: <86isjm70wq.fsf@n-dimensional.de> <20040108221040.GB785@mars>
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Fri, 09 Jan 2004 00:54:24 +0100
Message-ID: <86lloingi7.fsf@n-dimensional.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a.othieno@bluewin.ch (Arthur Othieno) writes:

> On Thu, Jan 08, 2004 at 07:25:41PM +0100, Hans Ulrich Niedermann wrote:
>> diff -Nru a/Documentation/digiepca.txt b/Documentation/digiepca.txt

>> -/usr/src/linux/Documentation/README.epca.dir/user.doc for more details.  Note,
>> +Documentation/README.epca.dir/user.doc for more details.  Note,
>                  ^^^^^^^^^^^^^^^^^^^^^^^^
> Non-existent.

Ooops. Thanks for checking.

OK, I'm going to add additional checks and correct my patches.

If we're going to get them in, we might as well do it right the
first time.

Uli
