Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSL3XsH>; Mon, 30 Dec 2002 18:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267096AbSL3XsH>; Mon, 30 Dec 2002 18:48:07 -0500
Received: from s142-179-222-244.ab.hsia.telus.net ([142.179.222.244]:30670
	"EHLO bluetooth.WNI.AD") by vger.kernel.org with ESMTP
	id <S267090AbSL3XpG>; Mon, 30 Dec 2002 18:45:06 -0500
Message-ID: <3E10DCEB.9050800@WirelessNetworksInc.com>
Date: Mon, 30 Dec 2002 16:55:23 -0700
From: Herman Oosthuysen <Herman@WirelessNetworksInc.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix Domke <tmbinc@elitedvb.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net> <20021230131725.GA16072@suse.de> <32797.62.98.199.18.1041274402.squirrel@webmail.roma2.infn.it> <20021230190034.GG3143@conectiva.com.br> <3E109EF1.5040901@WirelessNetworksInc.com> <3E10AFE7.6030301@elitedvb.net>
In-Reply-To: <3E10AFE7.6030301@elitedvb.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 23:53:30.0080 (UTC) FILETIME=[A7586E00:01C2B05E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felix Domke wrote:
> and as they might be some pitfalls (wrong aligning etc.), you can still 
> set the tabwidth to the one of the author. in that case, you didn't win 
> anything by using tabs, but you didn't loose either.
> 
Well, that is the problem - trying to figure out what the tab size of 
the author was.  It gets messy really quickly when a file was edited by 
multiple authors, using multiple tab widths. It then becomes impossible 
to figure out how to set the tab width to make the code indent properly.

Anyhoo, over the years, I learned not to care about it, since it is just 
too trivial an issue and there are more important things to worry about.

So, if I find a page's indentation bothersome, I run it through 'indent' 
for a private readable copy.  I even ported 'indent' to windoze a couple 
of years ago...

