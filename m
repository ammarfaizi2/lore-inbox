Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWFMVMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWFMVMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 17:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWFMVMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 17:12:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62655 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932247AbWFMVMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 17:12:22 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Gerhard Mack <gmack@innerfire.net>
Cc: jdow <jdow@earthlink.net>, Bernd Petrovitsch <bernd@firmix.at>,
       davids@webmaster.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
	 <193701c68d16$54cac690$0225a8c0@Wednesday>
	 <1150100286.26402.13.camel@tara.firmix.at>
	 <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
	 <Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 22:12:31 +0100
Message-Id: <1150233152.11159.121.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 13:37 -0400, Gerhard Mack wrote:
> 
> Innerfire.net used to be foraged as a spam sender every other month and 
> gmack@innerfire.net so often that I still have procmail filters to 
> redirect bounces to their own folder.  The thousands of messages I was 
> getting was infuriating but it has been a very rare event since I setup 
> SPF on my domain.
> 
> SPF may not filter spam much but if you set it to autofail you can reduce 
> the risk for innocent mail admins. 

There are much better ways to achieve that same effect. I don't get
_any_ faked bounces to dwmw2@infradead.org any more, and I didn't have
to disavow _valid_ forwarded mail in order to achieve that.

-- 
dwmw2

