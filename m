Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVAFMrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVAFMrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 07:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbVAFMrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 07:47:51 -0500
Received: from alog0039.analogic.com ([208.224.220.54]:13952 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262809AbVAFMrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 07:47:49 -0500
Date: Thu, 6 Jan 2005 07:46:53 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Christoph Hellwig <hch@infradead.org>
cc: Harald Dunkel <harald@CoWare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10: "[permanent]" modules?
In-Reply-To: <20050106092858.GB15162@infradead.org>
Message-ID: <Pine.LNX.4.61.0501060744330.17811@chaos.analogic.com>
References: <41DCE48E.5010604@coware.com> <20050106092858.GB15162@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Christoph Hellwig wrote:

> On Thu, Jan 06, 2005 at 08:11:10AM +0100, Harald Dunkel wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi folks,
>>
>> Seems that for 2.6.10 I cannot unload ide modules.
>> 'lsmod | grep permanent" lists
>
> ...
>
>> Is this on purpose?
>
> Yes.
>

Can you explain? Normally if a module is no longer in use, it
can be unloaded. I'm sure that there are number of folks
who would like to know how come it's now necessary to reboot
to get rid of some module no longer in use.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
