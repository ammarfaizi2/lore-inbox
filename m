Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUHCHfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUHCHfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 03:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUHCHfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 03:35:19 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:58079 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265256AbUHCHfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 03:35:13 -0400
References: <20040802015527.49088944.akpm@osdl.org> <410E3CAF.6080305@kolivas.org> <410F3423.3020409@yahoo.com.au>
Message-ID: <cone.1091518501.973503.9648.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm2
Date: Tue, 03 Aug 2004 17:35:01 +1000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin writes:

> Con Kolivas wrote:
>> Andrew Morton wrote:
> 
>> Anyone with feedback on this please cc me. This was developed separately 
>> from the -mm series which has heaps of other scheduler patches which 
>> were not trivial to merge with so there may be teething problems. Good 
>> reports dont hurt either ;)
>> 
> 
> I can't get onto the OSDL site now, but I seem to remember staircase
> having some performance problems on a few things. Hackbench and reaim
> from memory... are these fixed? was I dreaming?

Definitely dreaming I'm afraid :D

The performance on both reaim and hackbench has always equalled or exceeded 
mainline so thanks for bringing it up.

Con

