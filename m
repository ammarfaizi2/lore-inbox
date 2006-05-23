Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWEWCC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWEWCC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 22:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEWCC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 22:02:59 -0400
Received: from dvhart.com ([64.146.134.43]:5003 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751244AbWEWCC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 22:02:58 -0400
Message-ID: <44726D47.8030306@mbligh.org>
Date: Mon, 22 May 2006 19:02:47 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
Cc: Christian Trefzer <ctrefzer@gmx.de>, Matthias Schniedermeyer <ms@citd.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Knutar <jk-lkml@sci.fi>,
       Pau Garcia i Quiles <pgquiles@elpauer.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [IDEA] Poor man's UPS
References: <200605212131.47860.pgquiles@elpauer.org> <20060521224012.GB30855@hermes.uziel.local> <200605221604.16043.jk-lkml@sci.fi> <20060522151303.GA4538@hermes.uziel.local> <1148312458.17376.54.camel@localhost.localdomain> <20060522154830.GA5344@hermes.uziel.local> <4471E39C.1070003@citd.de> <20060522194040.GC5995@hermes.uziel.local> <447214EF.50803@argo.co.il>
In-Reply-To: <447214EF.50803@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Exactly, and since I cannot afford to buy one I'd have to build it
>> myself using mainly car batteries. The most complex part would be to
>> charge the batteries in a way that won't kill them over time. Building
>> such stuff into the PSU after the secondary coil and AC/DC converter
>> would save the double-conversion loss, therefore making this ideal for a
>> single machine. But I'm still brainstorming, lacking both money and
>> time.
> 
> Led/acid batteries are dangerous. Don't use them unless you know exactly 
> what you are doing.

Buy an intelligent charger for an RV. They're designed to do pretty much
exactly that (deep cycle marine batteries, probably).

M.
