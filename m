Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292701AbSCDS4k>; Mon, 4 Mar 2002 13:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292770AbSCDS40>; Mon, 4 Mar 2002 13:56:26 -0500
Received: from ns.ithnet.com ([217.64.64.10]:30725 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S292701AbSCDSzb>;
	Mon, 4 Mar 2002 13:55:31 -0500
Date: Mon, 4 Mar 2002 19:41:47 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Martin.Bligh@us.ibm.com, riel@conectiva.com.br, andrea@suse.de,
        phillips@bonn-fries.net, davidsen@tmr.com, mfedyk@matchmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-Id: <20020304194147.7bca4201.skraw@ithnet.com>
In-Reply-To: <20020304191804.2e58761c.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com>
	<190330000.1015261149@flay>
	<20020304191804.2e58761c.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002 19:18:04 +0100
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> As stated above: try to bring in per-node zones that are preferred by their cpu. This can work equally well for UP,SMP and NUMA (maybe even for cluster).
> UP=every zone is one or more preferred zone(s)
correct: UP=all zones are preferred zones for the single CPU

> SMP=every zone is one or more preferred zone(s)
correct: SMP=all zones are preferred zones for all CPUs

Regards,
Stephan

