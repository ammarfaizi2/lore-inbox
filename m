Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVJFTnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVJFTnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVJFTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:43:09 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:39907 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751332AbVJFTnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:43:08 -0400
Message-ID: <43457E06.7010401@nortel.com>
Date: Thu, 06 Oct 2005 13:41:58 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>, madhu.subbaiah@wipro.com,
       linux-kernel@vger.kernel.org
Subject: Re: select(0,NULL,NULL,NULL,&t1) used for delay
References: <1128606546.14385.26.camel@penguin.madhu> <9a8748490510060725x34426df0se719458caf9364fe@mail.gmail.com> <43457587.6000502@symas.com>
In-Reply-To: <43457587.6000502@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 19:42:03.0253 (UTC) FILETIME=[06869250:01C5CAAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:

> Insert obligatory joke about optimizing delay loops... ?

It's not a delay if there's a signal pending.

Chris
