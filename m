Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264102AbUE0NHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264102AbUE0NHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264349AbUE0NHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:07:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61095 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264102AbUE0NHt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:07:49 -0400
Date: Thu, 27 May 2004 10:09:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Vincent Lefevre <vincent@vinc17.org>
Subject: Re: [2.4.26] overcommit_memory documentation clarification
Message-ID: <20040527130925.GA13520@logos.cnet>
References: <20040509001045.GA23263@ay.vinc17.org> <20040509214941.GG7161@ay.vinc17.org> <20040527122042.GC13095@logos.cnet> <200405271430.11125@WOLK>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405271430.11125@WOLK>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 02:30:11PM +0200, Marc-Christian Petersen wrote:
> On Thursday 27 May 2004 14:20, Marcelo Tosatti wrote:
> 
> Hi Marcelo,

Hi Marc, 

> > We should or merge Alan's strict-overcommit patches (from RH's tree),
> > or fix the documentation.
> 
> I vote for the strict-overcommit thing. Do you have that handy for your 
> 2.4-bk?
> 
> Alan, prolly you? Or do we have to extract it from 
> linux-2.4.21-selected-ac-bits.patch? ;)

Alan is busy with other things.

The strict overcommit fixes need to be extraced and tested.

Dave Jones told me about it the other day.

Still haven't found the time to download RH's srpm.
