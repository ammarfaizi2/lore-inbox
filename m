Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVCaKT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVCaKT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 05:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVCaKT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 05:19:56 -0500
Received: from colin2.muc.de ([193.149.48.15]:29445 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261258AbVCaKTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 05:19:53 -0500
Date: 31 Mar 2005 12:19:52 +0200
Date: Thu, 31 Mar 2005 12:19:52 +0200
From: Andi Kleen <ak@muc.de>
To: Pau Aliagas <linuxnow@newtral.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, binutils@sources.redhat.com
Subject: Re: i386/x86_64 segment register issuses (Re: PATCH: Fix x86 segment register access)
Message-ID: <20050331101952.GF24804@muc.de>
References: <20050326020506.GA8068@lucon.org> <20050327222406.GA6435@lucon.org> <m14qev3h8l.fsf@muc.de> <Pine.LNX.4.58.0503291618520.6036@ppc970.osdl.org> <20050330015312.GA27309@lucon.org> <Pine.LNX.4.58.0503291815570.6036@ppc970.osdl.org> <20050330040017.GA29523@lucon.org> <Pine.LNX.4.58.0503300738430.6036@ppc970.osdl.org> <20050330210801.GA15384@lucon.org> <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503310015490.7060@pau.intranet.ct>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >That is what the assembler generates, and should have generated, for
> >"movw %ds,(%eax)" since Nov. 4, 2004.
> 
> Could this be the reason for the reported slowdown in the last six months?

No.

-Andi
