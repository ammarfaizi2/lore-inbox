Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbSLBLWH>; Mon, 2 Dec 2002 06:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSLBLWH>; Mon, 2 Dec 2002 06:22:07 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:15 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262500AbSLBLWG>; Mon, 2 Dec 2002 06:22:06 -0500
Date: Mon, 2 Dec 2002 09:29:25 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: sk@deeptown.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp: fix seq_file handling bug
Message-ID: <20021202112925.GB5924@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, sk@deeptown.org,
	linux-kernel@vger.kernel.org
References: <20021130153600.GF30931@conectiva.com.br> <20021201.234128.13598110.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021201.234128.13598110.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Dec 01, 2002 at 11:41:28PM -0800, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
 
>    	Now there is just this outstanding changeset. Now I have
>    some time to devote to fixing /proc/net/tcp seq_file handling.
    
> Please let me know once you have this fixed, as it is
> holding up my net merges :-)

I'll do, I was quite busy with Real Life(tm), but I'm back trying
to reproduce this one here at home, but failed to do so, I telnetted
to another machine and the ESTABLISHED connection was correctly shown,
so I'll be testing on a busier machine at the office, not on vmware.

- Arnaldo
