Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVCHAvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVCHAvw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVCHAr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:47:29 -0500
Received: from orb.pobox.com ([207.8.226.5]:35565 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262028AbVCHAoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:44:10 -0500
In-Reply-To: <422CE853.8070603@euroweb.net.mt>
References: <422CE853.8070603@euroweb.net.mt>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9b84705fe7666dfbbf1782ca85ae2ae0@pobox.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Scott Feldman <sfeldma@pobox.com>
Subject: Re: Sending IP datagrams
Date: Mon, 7 Mar 2005 16:42:55 -0800
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 7, 2005, at 3:48 PM, Josef E. Galea wrote:

> Hi,
>
> Is there any way, other than socket buffers, to send IP datagrams from 
> a kernel module? If yes, can you please point me to some good tutorial 
> or sample code

See net/core/pktgen.c for an example.

-scott

