Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSGRV4J>; Thu, 18 Jul 2002 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318338AbSGRV4J>; Thu, 18 Jul 2002 17:56:09 -0400
Received: from holomorphy.com ([66.224.33.161]:50316 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318290AbSGRV4J>;
	Thu, 18 Jul 2002 17:56:09 -0400
Date: Thu, 18 Jul 2002 14:59:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Wolfgang <w.morandell@netway.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with linux-2.4.19-rc2-ac1
Message-ID: <20020718215902.GU1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Wolfgang <w.morandell@netway.at>, linux-kernel@vger.kernel.org
References: <20020718214856.GA962@aragorn.groundzero.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718214856.GA962@aragorn.groundzero.at>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 11:48:59PM +0200, Wolfgang wrote:
> I have switched from linux-2.4.19-rc1-ac7 to linux-2.4.19-rc2-ac1 (both
> with preemptive patch). I use the same config but now thw kernel won't
> start and spits out the following. If someone could point out where the
> error is, I would be most grateful.
> Please Cc me.
>     Wolfgang

Please run ksymoops on this and send its output.


Thanks,
Bill
