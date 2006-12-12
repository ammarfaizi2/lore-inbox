Return-Path: <linux-kernel-owner+w=401wt.eu-S932317AbWLLSEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWLLSEU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 13:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWLLSEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 13:04:20 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57495 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932317AbWLLSET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 13:04:19 -0500
Message-ID: <457EEF1F.8040906@garzik.org>
Date: Tue, 12 Dec 2006 13:04:15 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Steve Wise <swise@opengridcomputing.com>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-git3 panics on boot - ata_piix/PCI related [still in -git17]
References: <5a4c581d0612110526j26a07b31q26edc075d4981cd8@mail.gmail.com>	<1165873362.20877.22.camel@stevo-desktop>	<1165941542.24482.5.camel@stevo-desktop> <20061212173516.1b7dc654@localhost.localdomain>
In-Reply-To: <20061212173516.1b7dc654@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> On Tue, 12 Dec 2006 10:39:02 -0600
> Steve Wise <swise@opengridcomputing.com> wrote:
> 
>> All,
>>
>> Bisecting reveals that this commit causes the problem:
> 
> Yes we know. There is a libata patch missing. As I said - if it is still
> missing by -rc1 I'll sort out a diff.

What's the patch?  Message-id?  I don't have anything from you in my 
patch queue.

	Jeff



