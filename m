Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267864AbUJGTcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbUJGTcy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUJGTbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:31:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33176 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267850AbUJGTaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:30:22 -0400
Date: Thu, 7 Oct 2004 15:30:21 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Ankit Jain <ankitjain1580@yahoo.com>
cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: VM Vs Swap Space
In-Reply-To: <20041007091753.34564.qmail@web52903.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0410071529370.12693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Ankit Jain wrote:

> (2) is it correct to use the term interchangeably

No. Virtual memory can mean a lot of other things, including
the address space of individual processes, or the kernel
address space.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

