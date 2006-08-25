Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWHYHUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWHYHUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 03:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWHYHUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 03:20:14 -0400
Received: from ozlabs.org ([203.10.76.45]:37033 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751117AbWHYHUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 03:20:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.42148.880959.99796@cargo.ozlabs.ibm.com>
Date: Fri, 25 Aug 2006 17:20:04 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: "Dong Feng" <middle.fengdong@gmail.com>,
       "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Unnecessary Relocation Hiding?
In-Reply-To: <200608250818.49139.ak@suse.de>
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com>
	<17646.14056.102017.127644@cargo.ozlabs.ibm.com>
	<a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
	<200608250818.49139.ak@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> Best is to avoid undefined behaviour in new code.

Of course.  But do you have a way to implement per_cpu() without it?

Paul.
