Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTHXS43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbTHXS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 14:56:29 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:29703 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261294AbTHXS40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 14:56:26 -0400
Date: Sun, 24 Aug 2003 20:52:46 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-rc3
Message-ID: <20030824185246.GG734@alpha.home.local>
References: <Pine.LNX.4.55L.0308231429530.19769@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308231429530.19769@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 02:30:45PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -rc3, with several fixes. The ACPI changes should fix most of
> well known ACPI issues: Please test it.

Hi Marcelo,

it's OK for me, both on my Dual Athlon and my VAIO (ACPI still OK BTW).
I also encountered the unresolved dependency that Eyal reported for tc35815,
but that's harmless (cf Ralf).

Cheers,
Willy

