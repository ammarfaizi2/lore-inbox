Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUCLNsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUCLNsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:48:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262109AbUCLNsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:48:11 -0500
Date: Fri, 12 Mar 2004 13:49:43 +0000
From: Joe Thornber <thornber@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Joe Thornber <thornber@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040312134943.GY18345@reti>
References: <1yygN-7Ut-65@gated-at.bofh.it> <1yyqt-83X-23@gated-at.bofh.it> <1yyqs-83X-17@gated-at.bofh.it> <1yyJK-8mD-41@gated-at.bofh.it> <1yzPs-1bI-21@gated-at.bofh.it> <1yGe9-7Rk-23@gated-at.bofh.it> <1yI6f-1Bj-3@gated-at.bofh.it> <1yQdz-1Uf-7@gated-at.bofh.it> <1yRCI-3lE-19@gated-at.bofh.it> <m3k71htm2l.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3k71htm2l.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 06:58:26AM +0100, Andi Kleen wrote:
> That's bad because it will break binary compatibility for existing
> x86-64 systems.  Don't add that please. Either emulate it properly
> or I will just declare the 32bit DM emulation broken and users will
> have to live with that.

So you want me to put in a seperate set of ioctl codes for
compatibility ?

- Joe
