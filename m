Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbTLIO0W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265867AbTLIOWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:22:44 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:38857 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S265866AbTLIOVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:21:04 -0500
Message-ID: <3FD5DAF6.8050100@stesmi.com>
Date: Tue, 09 Dec 2003 15:23:50 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <thornber@sistina.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
References: <20031209115806.GA472@reti> <Pine.LNX.4.44.0312091113510.1289-100000@logos.cnet> <20031209134551.GG472@reti>
In-Reply-To: <20031209134551.GG472@reti>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:

> On Tue, Dec 09, 2003 at 11:15:08AM -0200, Marcelo Tosatti wrote:
> 
>>I believe 2.6 is the right place for the device mapper. 
> 
> 
> So what's the difference between a new filesystem like XFS and a new
> device driver like dm ?

One thing you're missing is that after all, XFS has existed longer than
dm. Hell, XFS existed before 2.4 did (in a Linux form, I'm not talking
IRIX now).

XFS is also a new filesystem as you said but DM is meant as a
replacement for other functions, not strictly as an additive.

// Stefan

