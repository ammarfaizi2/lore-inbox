Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUIOXJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUIOXJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIOXIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:08:47 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:5264 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S267767AbUIOXF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:05:57 -0400
Date: Thu, 16 Sep 2004 00:05:44 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Netdev <netdev@oss.sgi.com>, leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
In-Reply-To: <1095275660.20569.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409160003590.23011@fogarty.jakma.org>
References: <4148991B.9050200@pobox.com>  <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>
 <1095275660.20569.0.camel@localhost.localdomain>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Alan Cox wrote:

> Last time I checked 2Ghz accelerators for intel and AMD were quite 
> cheap and also had the advantage they ran user mode code when idle 
> from network processing.

Indeed.

Unfortunately though, my vague understanding is, the interesting bits 
on the IXP, the microengines, are integrated with the XScale ASIC.

I agree it's silly to stick a general purpose CPU in there, but you 
get it for "free" anyway.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
War is an equal opportunity destroyer.
