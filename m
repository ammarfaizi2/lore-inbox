Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWGSBTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWGSBTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWGSBTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:19:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:26678 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932445AbWGSBTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:19:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aQpA+GOP+3QFKl15p0HzScfJD4GiznxD7h32JDgvOAIu4pxoUK2YQJHqv02IMOa8ptyS3mkJ+0jHk8NFTsXsjXtKxlWZvlOwy8yKt73qAs3kxjHi7dwhuteUUBQvSiVmhuPdGB0NElofPh6NoxW6tjvegctE2wJvBZpe4L96dzk=
Message-ID: <bda6d13a0607181819g40bcd61ev9674dfd747e3e163@mail.gmail.com>
Date: Tue, 18 Jul 2006 18:19:22 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
In-Reply-To: <20060718204718.GD18909@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BAFDB7.9050203@calebgray.com>
	 <1153128374.3062.10.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
	 <20060717160618.013ea282.diegocg@gmail.com>
	 <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
	 <20060717155151.GD8276@merlin.emma.line.org>
	 <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr>
	 <20060718204718.GD18909@merlin.emma.line.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And probably kernel hackers have better things to do than keeping that
> code building if they don't mean to support it. This touches the "stable
> APIs" can of worms again, so let's stop here before it springs open.

Hey, at least its stable APIs rather than stable ABIs :-)
