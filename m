Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbULPCHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbULPCHv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 21:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbULPCGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 21:06:01 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:48769 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262584AbULPCC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 21:02:58 -0500
Subject: Re: What if?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1102972125l.7475l.0l@werewolf.able.es>
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
	 <1101976424l.5095l.0l@werewolf.able.es>
	 <1101984361.28965.10.camel@tara.firmix.at>
	 <cpkc5i$84f$1@terminus.zytor.com>  <1102972125l.7475l.0l@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103158646.3585.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 16 Dec 2004 00:57:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-13 at 21:08, J.A. Magallon wrote:
> > Type-safe linkage, mainly.  That actually would be a nice thing.
> > 
> 
> And let the compiler do all what now is done by hand wrt driver methods,
> inheritance, specialized methods and so on, with a 1000% increase in security
> because compiler does not forget to do thinks, like we do ;)

This is not a C++ thing per se however. A future gcc could do type safe
linkage of C programs instead of C++.

