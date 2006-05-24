Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWEXF2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWEXF2z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbWEXF2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:28:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:1248 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932516AbWEXF2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:28:53 -0400
Message-ID: <4473EF08.1010709@pobox.com>
Date: Wed, 24 May 2006 01:28:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Ananda Raju <ananda.raju@neterion.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [-mm patch] drivers/net/s2io.c: make bus_speed[] static
References: <20060515005637.00b54560.akpm@osdl.org> <20060516153050.GC5677@stusta.de>
In-Reply-To: <20060516153050.GC5677@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>> ...
>> Changes since 2.6.17-rc3-mm1:
>> ...
>>  git-netdev-all.patch
>> ...
>>  git trees
>> ...
> 
> 
> This patch makes the needlessly global bus_speed[] static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

applied


