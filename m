Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWJWAjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWJWAjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 20:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWJWAjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 20:39:54 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6566 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750967AbWJWAjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 20:39:53 -0400
From: Andi Kleen <ak@suse.de>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine
Date: Mon, 23 Oct 2006 02:39:44 +0200
User-Agent: KMail/1.9.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Avi Kivity <avi@qumranet.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
References: <4537818D.4060204@qumranet.com> <p7364ecm1cl.fsf@verdi.suse.de> <adahcxvj2pq.fsf@cisco.com>
In-Reply-To: <adahcxvj2pq.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610230239.44764.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 October 2006 02:27, Roland Dreier wrote:
>  > Ah you're right. I forgot about the Yonahs. The number is probably
>  > not even that small (when Intel ships something x86 they tend to 
>  > do it in millions)
> 
> Right, it's quite a mainstream CPU -- for example every current
> Thinkpad has one I think. 

The question is if they all enable VT in the BIOS though. A lot of
systems don't and without BIOS support it doesn't work.

-Andi
