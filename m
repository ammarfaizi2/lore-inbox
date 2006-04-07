Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWDGPOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWDGPOp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWDGPOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:14:44 -0400
Received: from [4.79.56.4] ([4.79.56.4]:43930 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964798AbWDGPOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:14:44 -0400
Subject: Re: add new code section for kernel code
From: Arjan van de Ven <arjan@infradead.org>
To: saeed bishara <saeed.bishara@gmail.com>
Cc: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk,
       Linux-arm-toolchain@lists.arm.linux.org.uk
In-Reply-To: <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
References: <c70ff3ad0604060545o2e2dc8fcg2948ca53b3b3c8b0@mail.gmail.com>
	 <20060406151003.0ef4e637@localhost>
	 <c70ff3ad0604060947t728fbad9g2e3b35198f9b0f66@mail.gmail.com>
	 <c70ff3ad0604070402p355a5695y28b5806cbf7bed0a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 07 Apr 2006 17:14:24 +0200
Message-Id: <1144422864.3117.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-07 at 14:02 +0300, saeed bishara wrote:
> I noticed the arch/arm/boot/compressed/ files compiled with
> ffunction-sections switch, so I added the -fno-function-sections to
> the EXTRA_CFLAGS of the compressed/Makefile. And this solved the
> problem.

can you send a patch for this to Russell ?

