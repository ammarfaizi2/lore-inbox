Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbULBRdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbULBRdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbULBRdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:33:53 -0500
Received: from mail.joq.us ([67.65.12.105]:21171 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261698AbULBRcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:32:17 -0500
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Andrew Burgess <aab@cichlid.com>, linux-kernel@vger.kernel.org,
       jackit-devel@lists.sourceforge.net
Subject: Re: [Jackit-devel] Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
References: <200412021546.iB2FkK5a005502@cichlid.com>
	<20041202170315.067d7853@mango.fruits.de>
	<87y8ggekds.fsf@sulphur.joq.us>
	<20041202175756.0e50f101@mango.fruits.de>
	<20041202180910.0d77cbbb@mango.fruits.de>
From: "Jack O'Quin" <joq@io.com>
Date: 02 Dec 2004 11:32:49 -0600
In-Reply-To: <20041202180910.0d77cbbb@mango.fruits.de>
Message-ID: <87d5xsehby.fsf@sulphur.joq.us>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmidt <mista.tapas@gmx.net> writes:

> Hmm, i must have missed something in jackd's source. i thought
> control->process() directly calls the clients process callback..

It does.
-- 
  joq
