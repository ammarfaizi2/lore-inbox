Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266090AbUA2CJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 21:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266142AbUA2CJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 21:09:17 -0500
Received: from [211.167.76.68] ([211.167.76.68]:30439 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S266090AbUA2CJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 21:09:16 -0500
Date: Thu, 29 Jan 2004 10:05:54 +0800
From: Hugang <hugang@soulinfo.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040129100554.6453e6c8@localhost>
In-Reply-To: <1075336478.30623.317.camel@gaston>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
	<20040122211746.3ec1018c@localhost>
	<1074841973.974.217.camel@gaston>
	<20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
	<20040126181004.GB315@elf.ucw.cz>
	<1075154452.6191.91.camel@gaston>
	<1075156310.2072.1.camel@laptop-linux>
	<20040128202217.0a1f8222@localhost>
	<1075336478.30623.317.camel@gaston>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jan 2004 11:34:53 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Ok, had a quick look. I  _HATE_ those horrible macros you did. Why
> not just call asm functions or just inline the code ?

Good idea, But will try inline first. I can't sure change to call asm
function can works. But I'll try.

Thanks for look.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc
