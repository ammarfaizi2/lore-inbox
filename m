Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbULBE2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbULBE2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 23:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULBE2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 23:28:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:18593 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261552AbULBE2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 23:28:07 -0500
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Organization: Deban GNU/Linux Homesite
In-Reply-To: <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CZiZZ-0005ew-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 02 Dec 2004 05:28:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org> you wrote:
> I think you're making that up. Maybe there's some sw cult that swears by 
> "contract programming"

Design by Contract is the reason for descibing the agreement between
caller/callee as an contract. Bertran Meyer added the pre-conditions and
post-conditions (kind of asserts) to his Eiffel Language, and I dont think
that that is limited to a single system, but is also valid for bondaries
like an ABI. It describes conventions like syscall numbers, too.

Greetings
Bernd

PS: http://en.wikipedia.org/wiki/Eiffel_programming_language
