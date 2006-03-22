Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWCVRbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWCVRbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 12:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWCVRbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 12:31:31 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:14718 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751027AbWCVRba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 12:31:30 -0500
Subject: Re: 2.6.16-rt1
From: Daniel Walker <dwalker@mvista.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <442176EB.1050403@cybsft.com>
References: <20060320085137.GA29554@elte.hu> <441F8017.4040302@cybsft.com>
	 <20060321211653.GA3090@elte.hu> <4420B5F0.6000201@cybsft.com>
	 <20060322062932.GA17166@elte.hu> <44215CCB.1080005@cybsft.com>
	 <442176EB.1050403@cybsft.com>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:31:28 -0800
Message-Id: <1143048688.9127.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 10:10 -0600, K.R. Foley wrote:

> Found something interesting. Having Wakeup latency timing turned on
> makes a HUGE difference. I turned it off and recompiled and now I am
> seeing numbers back in line with what I expected from 2.6.16-rt4. Sorry,
> but I had no idea it would make that much difference. I don't have a
> complete run yet, but I have seen enough to know that I am not seeing
> tons of missed interrupts and the highest reported latency thus far is
> 61 usec.

Just Wakeup latency timing , and not latency tracing ?

Daniel

