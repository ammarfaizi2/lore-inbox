Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbUDRGgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 02:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbUDRGgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 02:36:46 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:40579 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264144AbUDRGgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 02:36:45 -0400
Message-ID: <408221DE.4050002@nortelnetworks.com>
Date: Sun, 18 Apr 2004 02:36:14 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
References: <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <1082228313.2580.25.camel@lade.trondhjem.org> <20040417222258.GA12893@flea> <1082249866.3619.43.camel@lade.trondhjem.org> <20040418050141.GA19414@flea>
In-Reply-To: <20040418050141.GA19414@flea>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer wrote:

> Client is a 200MHz ARM; server is a Linux host running 2.6.3 with the
> kernel nfs daemon; network is 100Mib.  There is nothing else on the
> network except intermittent broadband traffic.  Async is set on the
> server side.

Is the ARM that slow?  under 2MB/s seems odd to me...but them maybe I'm 
used to faster machines.

Chris
