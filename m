Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264601AbTGGD2F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 23:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTGGD2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 23:28:05 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:55464 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264601AbTGGD2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 23:28:03 -0400
Date: Mon, 7 Jul 2003 05:42:17 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
Message-ID: <20030707034217.GD303@louise.pinerecords.com>
References: <20030706184242.A20851@ucw.cz> <Pine.LNX.4.10.10307061740150.29935-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10307061740150.29935-100000@master.linux-ide.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [andre@linux-ide.org]
> 
> Caution!
> 
> Serverworks has OEM's who have BIOS's which are setup for a reason.
> If the BIOS is configured for any reason the the driver stomps on the BIOS
> settings there will be damage to the content on the media.
> 
> Just the view from an insider in the know.

Hmm, I certainly wouldn't expect a $3500 server to come with busted
IDE, but thanks for the suggestion, we'll take extra care.

-- 
Tomas Szepe <szepe@pinerecords.com>
