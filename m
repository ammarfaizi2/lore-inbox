Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269451AbTHSJjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269509AbTHSJjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:39:17 -0400
Received: from trained-monkey.org ([209.217.122.11]:51721 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S269451AbTHSJjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:39:16 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: Qla1280 update to 3.23.24
References: <200308181606.h7IG6utZ021778@hera.kernel.org>
	<20030818161800.GE24693@gtf.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Aug 2003 05:26:13 -0400
In-Reply-To: <20030818161800.GE24693@gtf.org>
Message-ID: <m3lltqroay.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

Jeff> Since we have people _constantly_ screwing this up (but of
Jeff> course, never you, Jes :)), please use the KERNEL_VERSION()
Jeff> macro instead of open-coding the kernel version you are testing.
Jeff> It makes these tests not only harder to screw up, but easier to
Jeff> read, too.

Thats why I used the hex-value and not decimal. Sorry, maybe I am old
fashioned but I always disliked that macro and the hex values are
really easy to read which is why I decided to stick to that.

Cheers,
Jes
