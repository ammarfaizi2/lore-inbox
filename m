Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTGGGaz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTGGGaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:30:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:38055
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264728AbTGGGaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 02:30:55 -0400
Subject: Re: 2.4.21 ServerWorks DMA Bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: Andre Hedrick <andre@linux-ide.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030707034217.GD303@louise.pinerecords.com>
References: <20030706184242.A20851@ucw.cz>
	 <Pine.LNX.4.10.10307061740150.29935-100000@master.linux-ide.org>
	 <20030707034217.GD303@louise.pinerecords.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057560151.2413.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jul 2003 07:42:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-07 at 04:42, Tomas Szepe wrote:
> > Just the view from an insider in the know.
> 
> Hmm, I certainly wouldn't expect a $3500 server to come with busted
> IDE, but thanks for the suggestion, we'll take extra care.

You might also want to check with HPaq about BIOS updates. I have
seen a couple of boxes which didnt set DMA but meant to or did
after BIOS update.


