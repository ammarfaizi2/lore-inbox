Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUENNuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUENNuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265285AbUENNuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:50:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33172 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265281AbUENNuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:50:24 -0400
Date: Fri, 14 May 2004 09:48:08 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens-dated-1085404045.d167@endorphin.org>
cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] AES i586 optimized, regparm fixed
In-Reply-To: <20040514130724.GA8081@ghanima.endorphin.org>
Message-ID: <Xine.LNX.4.44.0405140945590.20213-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004, Fruhwirth Clemens wrote:

> James, if the patch suits your taste, please take care of forwarding it to
> Andrew or Linus.

There is still the binary license issue, and how to ensure this is built 
instead of the generic AES module for the right architectures.


- James
-- 
James Morris
<jmorris@redhat.com>


