Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268193AbUHFQzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268193AbUHFQzs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268201AbUHFQvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:51:23 -0400
Received: from colin2.muc.de ([193.149.48.15]:787 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268181AbUHFQqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:46:54 -0400
Date: 6 Aug 2004 18:46:47 +0200
Date: Fri, 6 Aug 2004 18:46:47 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com, shemminger@osdl.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [0/3]kprobes-base-268-rc3.patch
Message-ID: <20040806164647.GA60207@muc.de>
References: <2pMzT-XA-21@gated-at.bofh.it> <m3hdrhyhuy.fsf@averell.firstfloor.org> <20040806123757.GB3376@in.ibm.com> <20040806151625.GA96991@muc.de> <20040806163114.GB3732@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806163114.GB3732@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its good enough for Kprobes. Also kprobes needs int3 handler to be an 
> interrupt gate, as of now its system gate. Please see my next mail for updated 

Looks fine for me now. Thanks.

-Andi
