Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbUDFSds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263961AbUDFSds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:33:48 -0400
Received: from mail.shareable.org ([81.29.64.88]:39576 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263954AbUDFSdr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:33:47 -0400
Date: Tue, 6 Apr 2004 19:33:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Sergiy Lozovsky <serge_lozovsky@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
Message-ID: <20040406183344.GA27970@mail.shareable.org>
References: <40712952.6040100@aitel.hist.no> <20040405170537.94432.qmail@web40513.mail.yahoo.com> <20040406133246.GA19091@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406133246.GA19091@hh.idb.hist.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> The simple approach is to replace all (big) stack
> allocations with an explicit stack structure that you manages
> on the heap.

Maybe Stackless Python is a better fit for this kernel project? 

:) [1/2 serious]

-- Jamie
