Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbSLEVdq>; Thu, 5 Dec 2002 16:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267508AbSLEVdA>; Thu, 5 Dec 2002 16:33:00 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:24583 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267506AbSLEVbY>; Thu, 5 Dec 2002 16:31:24 -0500
Date: Thu, 5 Dec 2002 22:38:50 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ipv4: how to choose src ip?
Message-ID: <20021205213850.GA25006@louise.pinerecords.com>
References: <20021205190054.GE23877@louise.pinerecords.com> <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1021205152058.18105A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> determining factors. If you have two or more IP addresses that
> are capable of putting the data-gram on the wire, the first one,
> i.e., the address used to initialize the interface first, will
> be the one that is used in out-going packets.

Thanks for the clarification on this one.

-- 
Tomas Szepe <szepe@pinerecords.com>
