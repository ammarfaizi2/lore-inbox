Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUEDPd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUEDPd3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbUEDPd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:33:29 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:55937 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S264444AbUEDPd2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:33:28 -0400
Date: Tue, 4 May 2004 16:33:11 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 and diskless swap (nbd? nfs?)
In-Reply-To: <20040503135856.GF1188@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.58.0405041629410.1979@fogarty.jakma.org>
References: <Pine.LNX.4.58.0405030037490.22749@fogarty.jakma.org>
 <20040503135856.GF1188@openzaurus.ucw.cz>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Pavel Machek wrote:

> There's no way to make swapping over network work.

Ok, fair enough.
 
> nbd patches never worked 100% reliably.

:(
 
> You'd have to write "nbd over netpoll".

Ok. :( So, diskless means no swap.

> 				Pavel

thanks for the answer.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
"Absolutely nothing should be concluded from these figures except that
no conclusion can be drawn from them."
(By Joseph L. Brothers, Linux/PowerPC Project)
