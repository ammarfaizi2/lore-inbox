Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUBYXch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUBYXcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:32:20 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:22796 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261644AbUBYXaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:30:10 -0500
Message-ID: <403D325F.9070907@techsource.com>
Date: Wed, 25 Feb 2004 18:40:15 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Grigor Gatchev <grigor@zadnik.org>
CC: Christer Weinigel <christer@weinigel.se>,
       Nikita Danilov <Nikita@Namesys.COM>, root@chaos.analogic.com,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
In-Reply-To: <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think TOE (TCP/IP stack on the ethernet card) might be one of those 
things which doesn't fit cleanly into the layered model.

