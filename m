Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSD2PaI>; Mon, 29 Apr 2002 11:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSD2PaH>; Mon, 29 Apr 2002 11:30:07 -0400
Received: from zero.tech9.net ([209.61.188.187]:51982 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312576AbSD2PaG>;
	Mon, 29 Apr 2002 11:30:06 -0400
Subject: Re: 2.5.7 pre-emptive support
From: Robert Love <rml@tech9.net>
To: chris.2.dobbs@bt.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F66469FCE9C5D311B8FF0000F8FE9E070965D2AC@mbtlipnt03.btlabs.bt.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 29 Apr 2002 11:30:03 -0400
Message-Id: <1020094203.20438.63.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-29 at 06:48, chris.2.dobbs@bt.com wrote:

> I am getting unresolved symbols(mainly 'preemp_schedule' ) in most modules
> when i compile 2.5.7 with pre-emptive support. Am i missing some base driver
> or another patch or something for this option????.

Try something more recent, like 2.5.11.

	Robert Love

