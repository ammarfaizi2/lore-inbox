Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVFGOa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVFGOa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVFGOa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:30:59 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:6404 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261878AbVFGOaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:30:55 -0400
Message-ID: <42A6C8C9.7090106@rtr.ca>
Date: Wed, 08 Jun 2005 06:30:33 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>	<42A47376.80203@rtr.ca> <87u0kbhqsz.fsf@stark.xeocode.com>	<42A6AE3E.7070401@rtr.ca> <87is0qi8bo.fsf@stark.xeocode.com>
In-Reply-To: <87is0qi8bo.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
>
> It's 2.6.11-bk6-libata-dev1.patch which I appear to have downloaded May 15th.
> (Sorry I guess "latest" wasn't very precise)

Mmm.. the relevant ioctl's look identical to the 02-Mar-2005
libata-dev1.patch that I am using here, so if that is what you
really are using, then smartctl should be working.

???
