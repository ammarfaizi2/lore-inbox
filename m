Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUEJPjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUEJPjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264750AbUEJPjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:39:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17584 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264748AbUEJPjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:39:45 -0400
Date: Mon, 10 May 2004 11:39:36 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andi Kleen <ak@muc.de>
cc: Stephen Hemminger <shemminger@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Distributions vs kernel development
In-Reply-To: <m38yg4hyf1.fsf@averell.firstfloor.org>
Message-ID: <Xine.LNX.4.44.0405101137310.1943-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004, Andi Kleen wrote:

> The reiserfs attribute patch has been submitted many times,
> but rejected for totally bogus reasons. You know who to complain to.

I'd really like to see the xattr + SELinux stuff go in, so that SELinux 
users can have filesystem labeling under Reiserfs.  I'll volunteer to help 
maintain this part of the code in mainline.


- James
-- 
James Morris
<jmorris@redhat.com>


