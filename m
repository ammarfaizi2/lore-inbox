Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVKLFer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVKLFer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 00:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVKLFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 00:34:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:40846 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932075AbVKLFeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 00:34:46 -0500
Message-ID: <43757EF4.1060600@pobox.com>
Date: Sat, 12 Nov 2005 00:34:44 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Re: [2.6.15-rc1] VFS: file-max limit 400490 reached
References: <43757D18.9090109@pobox.com> <20051112053052.GA1210@taniwha.stupidest.org>
In-Reply-To: <20051112053052.GA1210@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Sat, Nov 12, 2005 at 12:26:48AM -0500, Jeff Garzik wrote:
> 
> 
>>	VFS: file-max limit 400490 reached
> 
> 
> does lsof show anything useful?

Alas, no.  [from memory, I've since rebooted]

lsof | wc -l
808


