Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264189AbUD0PlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbUD0PlR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUD0PlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:41:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:28682 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264189AbUD0PkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:40:03 -0400
Message-ID: <408E7FBE.7010700@techsource.com>
Date: Tue, 27 Apr 2004 11:43:58 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Tom Vier <tmv@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898834.7040803@techsource.com> <20040424022458.GA16166@zero>
In-Reply-To: <20040424022458.GA16166@zero>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tom Vier wrote:
> On Fri, Apr 23, 2004 at 05:18:44PM -0400, Timothy Miller wrote:
> 
>>In a drive with multiple platters and therefore multiple heads, you 
>>could read/write from all heads simultaneously.  Or is that how they 
>>already do it?
> 
> 
> fwih, there was once a drive that did this. the problem is track alignment.
> these days, you'd need seperate motors for each head.
> 

Oh, yeah.  Forget the separate motors.  Would definately need that to 
move heads independently.

The problem is track alignment.  Don't drives dedicate one track on one 
platter as an alignment track?

