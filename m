Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWBWNNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWBWNNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWBWNNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:13:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27620 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751284AbWBWNNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:13:01 -0500
Date: Thu, 23 Feb 2006 08:12:49 -0500
From: Alan Cox <alan@redhat.com>
To: Thomas Koeller <thomas@koeller.dyndns.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty flip buffer handling
Message-ID: <20060223131249.GC977@devserv.devel.redhat.com>
References: <200602230214.08548.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602230214.08548.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 02:14:08AM +0100, Thomas Koeller wrote:
> Add a couple of 'const' qualifiers to the TTY flip buffer APIs,
> where appropriate.
> 
> Signed-off-by: Thomas Koeller <thomas@koeller.dyndns.org>

Acked-by: Alan Cox <alan@redhat.com>

--
	The Master doesn't talk, he acts.
	When his work is done, 
	the people say, "Amazing: 
	we did it, all by ourselves!"		-- Lao-tzu
