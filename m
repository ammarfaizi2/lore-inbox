Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWFAVjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWFAVjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWFAVjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:39:37 -0400
Received: from ping.uio.no ([129.240.78.2]:52126 "EHLO ping.uio.no")
	by vger.kernel.org with ESMTP id S1750723AbWFAVjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:39:37 -0400
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USB devices fail unnecessarily on unpowered hubs
References: <Pine.LNX.4.44L0.0606011050330.6784-100000@iolanthe.rowland.org>
	<Pine.LNX.4.61.0606011104140.1745@chaos.analogic.com>
	<20060601152344.GB23746@csclub.uwaterloo.ca>
From: ilmari@ilmari.org (=?utf-8?q?Dagfinn_Ilmari_Manns=C3=A5ker?=)
Organization: Program-, Informasjons- og Nettverksteknologisk Gruppe, UiO
Mail-Copies-To: nobody
Date: Thu, 01 Jun 2006 23:39:15 +0200
In-Reply-To: <20060601152344.GB23746@csclub.uwaterloo.ca> (Lennart
 Sorensen's message of "Thu, 1 Jun 2006 11:23:44 -0400")
Message-ID: <d8jodxcmu7w.fsf@ritchie.ping.uio.no>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Exiscan-Spam-Score: -7.8 (-------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen <lsorense@csclub.uwaterloo.ca> writes:

> A scanner certainly uses more power with the scanner light on than with
> it off, and it starts out off until it is in use on most scanners.  Of
> course I have never seen a usb powered scanner, so it doesn't seem to
> matter.

Oh, they've been around for years. The CanoScan LiDE 25 is an example:
<http://www.usa.canon.com/consumer/controller?act=ModelTechSpecsAct&fcategoryid=119&modelid=11463>

-- 
ilmari
"A disappointingly low fraction of the human race is,
 at any given time, on fire." - Stig Sandbeck Mathisen
