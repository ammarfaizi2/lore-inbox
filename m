Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbVIDMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbVIDMlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVIDMlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:41:45 -0400
Received: from mxout5.netvision.net.il ([194.90.9.29]:25678 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S1750804AbVIDMlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:41:44 -0400
Date: Sun, 04 Sep 2005 17:38:48 +0300
From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Brand-new notebook useless with Linux...
In-reply-to: <E1EBje3-0002GW-00@chiark.greenend.org.uk>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Mail-followup-to: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
 Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Message-id: <20050904143848.GA14897@sashak.softier1.local>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <200509031859_MC3-1-A720-F705@compuserve.com>
 <E1EBje3-0002GW-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02:50 Sun 04 Sep     , Matthew Garrett wrote:
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > Audio ("unknown codec")
> 
> snd-ati-atiixp ought to drive it - if it doesn't, that's probably a bug.
> 
> > Modem ("no codec available")
> 
> It's a winmodem. What were you expecting?

snd-atiixp-modem should drive this too.

Sasha.
