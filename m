Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbUAMTvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUAMTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:51:05 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.120]:1672 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S264933AbUAMTvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:51:03 -0500
Message-ID: <40044B9A.4070300@myrealbox.com>
Date: Tue, 13 Jan 2004 11:48:42 -0800
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Lutomirski <luto@myrealbox.com>
CC: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
Subject: Re: loopback over reiserfs broken in 2.6.1-mm1
References: <4002F317.2070102@myrealbox.com> <200401122245.i0CMjYbn015552@car.linuxhacker.ru> <40042A0F.7080401@myrealbox.com>
In-Reply-To: <40042A0F.7080401@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> I'm guessing it's the AIO stuff -- I'll try -mm2 later today.

Nope -- still broken in -mm2.

--Andy

