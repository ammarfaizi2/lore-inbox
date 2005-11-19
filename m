Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVKSMhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVKSMhK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVKSMhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:37:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31683 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751098AbVKSMhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:37:09 -0500
Subject: Re: [PATCH 1/5] slab: rename obj_reallen to obj_size
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
In-Reply-To: <437F1BD7.8070504@colorfullife.com>
References: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>
	 <437F1333.5010308@colorfullife.com> <1132401896.17963.5.camel@localhost>
	 <437F1BD7.8070504@colorfullife.com>
Date: Sat, 19 Nov 2005 14:37:02 +0200
Message-Id: <1132403823.17963.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-19 at 13:34 +0100, Manfred Spraul wrote:
> It would just cause confusion: The name of the function and the name of 
> the member must be identical.

Agreed, please see the patch I sent.

			Pekka

