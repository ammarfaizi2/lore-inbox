Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbREXTQT>; Thu, 24 May 2001 15:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbREXTQK>; Thu, 24 May 2001 15:16:10 -0400
Received: from james.kalifornia.com ([208.179.59.2]:22613 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S262212AbREXTPv>; Thu, 24 May 2001 15:15:51 -0400
Message-ID: <3B0D5DE0.4090906@blue-labs.org>
Date: Thu, 24 May 2001 12:15:44 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9+) Gecko/20010522
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Selectively refusing TCP connections
In-Reply-To: <Pine.LNX.4.33.0105231841230.1163-100000@baphomet.bogo.bogus> <20010523202332.A31402@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an example somewhere of this?

David

>You can push a BPF (LPF) filter expression onto a LISTEN socket that checks
>every incoming packet using SO_ATTACH_FILTER.
>


