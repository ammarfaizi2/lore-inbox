Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265919AbTL3Ttm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbTL3Ttm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:49:42 -0500
Received: from nameserver1.brainwerkz.net ([209.251.159.130]:50849 "EHLO
	nameserver1.mcve.com") by vger.kernel.org with ESMTP
	id S265919AbTL3Ttl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:49:41 -0500
Message-ID: <33036.209.251.159.140.1072813780.squirrel@mail.mainstreetsoftworks.com>
Date: Tue, 30 Dec 2003 14:49:40 -0500 (EST)
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: "Brad House" <brad_mssw@gentoo.org>
To: <sflory@rackable.com>
In-Reply-To: <3FF1D567.4040205@rackable.com>
References: <65095.68.105.173.45.1072761027.squirrel@mail.mainstreetsoftworks.com>
        <20031230052041.GA7007@gtf.org>
        <65025.68.105.173.45.1072765590.squirrel@mail.mainstreetsoftworks.com>
        <3FF11CC2.7040209@pobox.com>
        <3FF1D567.4040205@rackable.com>
X-Priority: 3
Importance: Normal
Cc: <brad_mssw@gentoo.org>, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>, <Atul.Mukker@lsil.com>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I thought this was megaraid2
from the .h file:
#define MEGARAID_VERSION        \
        "v2.00.3 (Release Date: Wed Feb 19 08:51:30 EST 2003)\n"

Perhaps I should search around and see if I can find a later one
though ??

-Brad

>    Wouldn't it be more useful to port megaraid2 from 2.4?
>
> --
> There is no such thing as obsolete hardware.
> Merely hardware that other people don't want.
> (The Second Rule of Hardware Acquisition)
> Sam Flory  <sflory@rackable.com>



