Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUIMT0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUIMT0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUIMT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:26:20 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:15773 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S268878AbUIMT0T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:26:19 -0400
Date: Mon, 13 Sep 2004 20:25:35 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Tonnerre <tonnerre@thundrix.ch>
cc: Willy Tarreau <willy@w.ods.org>,
       Toon van der Pas <toon@hout.vanvergehaald.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Wolfpaw - Dale Corse <admin@wolfpaw.net>, kaukasoi@elektroni.ee.tut.fi,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial
 of Service Attack
In-Reply-To: <20040913190741.GD19399@thundrix.ch>
Message-ID: <Pine.LNX.4.61.0409132024300.23011@fogarty.jakma.org>
References: <002301c498ee$1e81d4c0$0200a8c0@wolf> <1095008692.11736.11.camel@localhost.localdomain>
 <20040912192331.GB8436@hout.vanvergehaald.nl> <Pine.LNX.4.61.0409130413460.23011@fogarty.jakma.org>
 <Pine.LNX.4.61.0409130425440.23011@fogarty.jakma.org> <20040913041846.GD2780@alpha.home.local>
 <20040913190741.GD19399@thundrix.ch>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2004, Tonnerre wrote:

> Problem there: you can fake connection errors almost as easily as 
> sending an RST packet, so the DoS might reappear, might it not?

Sure, but TCP just isnt going to solve this for you.

> 				Tonnerre

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
All progress is based upon a universal innate desire of every organism
to live beyond its income.
 		-- Samuel Butler, "Notebooks"
