Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUAUQHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUAUQHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:07:12 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:3373 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262848AbUAUQHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:07:09 -0500
Date: Wed, 21 Jan 2004 17:07:07 +0100 (CET)
From: Lukasz Trabinski <lukasz@trabinski.net>
X-X-Sender: lukasz@oceanic.wsisiz.edu.pl
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: Linux 2.4.25-pre6
In-Reply-To: <1074686081.16045.141.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.58LT.0401211702100.23288@oceanic.wsisiz.edu.pl>
References: <200401202125.i0KLPOgh007806@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401201940470.29729@logos.cnet> 
 <Pine.LNX.4.58LT.0401210746350.2482@lt.wsisiz.edu.pl> 
 <Pine.LNX.4.58L.0401210852490.5072@logos.cnet> 
 <Pine.LNX.4.58LT.0401211225560.31684@oceanic.wsisiz.edu.pl>
 <1074686081.16045.141.camel@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004, David Woodhouse wrote:

> Neither do I understand why i_list.prev is corrupt. Not seeing the oops
> and knowing what it actually was doesn't help. Rik?

I have logs from this host on different machine - no ooops.

Emergency Sync and Emergency Remount R/O didn't work.

SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem showPc unRaw Sync 
showTa
sks Unmount 
SysRq : Emergency Sync
SysRq : Emergency Remount R/O



-- 
*[ £ukasz Tr±biñski ]*
