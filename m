Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUBNXyS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUBNXyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:54:18 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:63631 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263600AbUBNXyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:54:16 -0500
Date: Sun, 15 Feb 2004 00:54:15 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: status of copy-on-write filesystem?
Message-ID: <20040214235415.GA13839@MAIL.13thfloor.at>
Mail-Followup-To: Chris Friesen <cfriesen@nortelnetworks.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <402A46A7.9070302@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402A46A7.9070302@nortelnetworks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 10:13:43AM -0500, Chris Friesen wrote:
> 
> I'm doing some work where it would simplify things greatly to have 
> copy-on-write semantics available.
> 
> I've seen overlayfs and the proposed "-union" option for mount,  but 
> there doesn't seem to be anything thats really ready for serious use.
> 
> Am I missing something?  Is someone working on this?

http://vserver.13thfloor.at/TBVFS

no active work atm, but some info/links maybe

HTH,
Herbert

> Thanks,
> 
> Chris
> 
> 
> -- 
> Chris Friesen                    | MailStop: 043/33/F10
> Nortel Networks                  | work: (613) 765-0557
> 3500 Carling Avenue              | fax:  (613) 765-2986
> Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
