Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSJCJ1i>; Thu, 3 Oct 2002 05:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbSJCJ1i>; Thu, 3 Oct 2002 05:27:38 -0400
Received: from dp.samba.org ([66.70.73.150]:6883 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263215AbSJCJ1i>;
	Thu, 3 Oct 2002 05:27:38 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15772.3784.658821.573034@nanango.paulus.ozlabs.org>
Date: Thu, 3 Oct 2002 19:32:56 +1000 (EST)
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, Murali N Vilayannur <vilayann@thomson.cse.psu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interruptible rwsems
In-Reply-To: <13734.1033636659@warthog.cambridge.redhat.com>
References: <13734.1033636659@warthog.cambridge.redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells writes:

> Here's a patch to add interruptible down functions for rwsems (developed by
> Murali N Vilayannur with help from myself).

Do we actually have a potential use for this, or is it just cool
infrastructure?

Regards,
Paul.
