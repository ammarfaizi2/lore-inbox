Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVFWXiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVFWXiA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 19:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVFWXh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 19:37:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:40373 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262894AbVFWXg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 19:36:26 -0400
Subject: Re: PATCH: "Ok" -> "OK" in messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Woodhouse <dwmw2@infradead.org>,
       "Sean M. Burke" <sburke@cpan.org>, trivial@rustcorp.com.au
In-Reply-To: <42BAE3B1.5010209@am.sony.com>
References: <42985251.6030006@cpan.org>
	 <1117279792.32118.11.camel@localhost.localdomain>
	 <20050528125430.GB3870@ojjektum.uhulinux.hu> <42BAE3B1.5010209@am.sony.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119569595.18898.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 24 Jun 2005 00:33:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-06-23 at 17:30, Tim Bird wrote:
> Language neutrality is not a goal for kernel messages,
> that I'm aware of.  I disagree with this change because
> it yields a net reduction in understanding what's going
> on during booting.

Just change the "Uncompressing" to "Decompressing". The other proposal
of including the version is a good one as is correcting the "Ok".
Whatever occurs porting the code into English can only be a good thing.

