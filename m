Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261746AbVHBTiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261746AbVHBTiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVHBTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 15:38:12 -0400
Received: from pc2033.sks3.muni.cz ([147.251.211.33]:38825 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S261746AbVHBTiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 15:38:11 -0400
Date: Tue, 2 Aug 2005 21:38:06 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5 - ACPI regression
Message-ID: <20050802193806.GA2427@mail.muni.cz>
References: <20050802175336.GA2959@mail.muni.cz> <5a4c581d05080211595cc07fa3@mail.gmail.com> <20050802190526.GB2959@mail.muni.cz> <200508022118.51562.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200508022118.51562.rjw@sisk.pl>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 09:18:51PM +0200, Rafael J. Wysocki wrote:
> > I did not notice before, but my values (capacity and so on) are completely
> > wrong. It should contain values in mWh instead of mAh.
> 
> There's a new kernel boot oprion ec_polling that you may want to try.

Now it's ok except asus_acpi module does not work any more.

It complains about generic hot key driver even when I do not have compiled
generic hot key driver in.

-- 
Luká¹ Hejtmánek
