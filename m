Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVIEErI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVIEErI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVIEErI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:47:08 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:5079 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932203AbVIEErH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:47:07 -0400
Message-ID: <46230.10.10.10.10.1125895623.squirrel@linux1>
In-Reply-To: <20050905043613.GD30279@alpha.home.local>
References: <35547.10.10.10.10.1125892279.squirrel@linux1>
    <20050905040311.29623.qmail@web50204.mail.yahoo.com>
    <50570.10.10.10.10.1125893576.squirrel@linux1>
    <20050905043613.GD30279@alpha.home.local>
Date: Mon, 5 Sep 2005 00:47:03 -0400 (EDT)
Subject: Re: RFC: i386: kill !4KSTACKS
From: "Sean" <seanlkml@sympatico.ca>
To: "Willy Tarreau" <willy@w.ods.org>
Cc: "Alex Davis" <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, September 5, 2005 12:36 am, Willy Tarreau said:

> Well, to be fair, most laptop users today are in companies which provide
> them with the model the staff has chosen for all the employees. And
> employees
> try to install Linux on them anyway. That's how you end up with things
> like
> ndiswrapper, because the people who make those notebooks for companies
> don't
> care at all about their customers ; what they want is negociate with the
> staff to sell them 2000 laptops, and that's all.

Companies that provide laptops to their employees tend to frown on the
users installing a bunch of stuff anyway.   If the company was buying the
laptop to run Linux it would be spec'd appropriately.

But the real crux of the argument here is not whether or not people should
ever use binary-only drivers, it's whether the open source kernel
developers should spend any time worrying about it or not.

Cheers,
Sean


