Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbTIDVlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265596AbTIDVlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:41:21 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:51161 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265594AbTIDVlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:41:17 -0400
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jimwclark@ntlworld.com
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309042212.25052.jimwclark@ntlworld.com>
References: <Pine.LNX.4.44.0309041628380.14715-100000@chimarrao.boston.redhat.com>
	 <200309042212.25052.jimwclark@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062711609.22634.67.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Thu, 04 Sep 2003 22:40:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-04 at 22:12, James Clark wrote:
> If a relatively small kernel component can be turned on/off and upgraded at 
> will, without changing ANYTHING else, this would be a big step forward.

It already can, the install tool just happens to involve invoking gcc
and wrapping it nicely. People have already solved that. I'm actually
less worried in some ways about the binary only module wrapper question
because source wrappers around a binary module to handle glueing them
together puts the shipper in conflict with a patent filing owned by a
very large hardware company as well as in GPL questionmarks..

