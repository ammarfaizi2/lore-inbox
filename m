Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbUBZPoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUBZPoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:44:22 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:20214 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262515AbUBZPoV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:44:21 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Rik van Riel <riel@redhat.com>, Timothy Miller <miller@techsource.com>
Subject: Re: A Layered Kernel: Proposal
Date: Thu, 26 Feb 2004 09:43:21 -0600
X-Mailer: KMail [version 1.2]
Cc: Grigor Gatchev <grigor@zadnik.org>,
       Christer Weinigel <christer@weinigel.se>,
       Nikita Danilov <Nikita@Namesys.COM>, <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402251955040.8976-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402251955040.8976-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Message-Id: <04022609432200.08433@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 18:55, Rik van Riel wrote:
> On Wed, 25 Feb 2004, Timothy Miller wrote:
> > I think TOE (TCP/IP stack on the ethernet card) might be one of those
> > things which doesn't fit cleanly into the layered model.
>
> That's not a big problem though, as long as the Linux network
> stack keeps outperforming TOE adapters ;)

Until you add IPSEC...

Unless the TOE has the same security support (encrypt some packets, not
others, require verification from some networks, not others,...), and
flexibility that the Linux network stack has, and ...
