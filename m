Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030473AbWHOT3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030473AbWHOT3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWHOT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:29:30 -0400
Received: from ptb-relay03.plus.net ([212.159.14.214]:44773 "EHLO
	ptb-relay03.plus.net") by vger.kernel.org with ESMTP
	id S1030473AbWHOT32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:29:28 -0400
Message-ID: <44E22091.4000500@mauve.plus.com>
Date: Tue, 15 Aug 2006 20:29:21 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, akpm@osdl.org, dmccr@us.ibm.com
Subject: Re: Shared page tables patch... some results
References: <1155638047.3011.96.camel@laptopd505.fenrus.org> <20060815175933.3e284567.diegocg@gmail.com>
In-Reply-To: <20060815175933.3e284567.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:
> El Tue, 15 Aug 2006 12:34:07 +0200,
> Arjan van de Ven <arjan@infradead.org> escribió:
> 
>> Just booting into runlevel 5 and logging into gnome (without starting

> It's possible to get the patch to test it? (saving memory is one of those
> things that makes people want to try patches ;) It'd be interesting to see
> how this affects to other (mine) environments. 

I always wondered what happened to 'mergemem' - which did similar things 
in 2.0.33.
