Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbRHNJrP>; Tue, 14 Aug 2001 05:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268902AbRHNJrF>; Tue, 14 Aug 2001 05:47:05 -0400
Received: from vitelus.com ([64.81.36.147]:11012 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S268332AbRHNJqx>;
	Tue, 14 Aug 2001 05:46:53 -0400
Date: Tue, 14 Aug 2001 02:46:54 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Christian Widmer <cwidmer@iiic.ethz.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3c905b works with 10bt hub - not with 10/100 switch
Message-ID: <20010814024654.A492@vitelus.com>
In-Reply-To: <20010814021445.A7454@vitelus.com> <01081411422301.01754@asterix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01081411422301.01754@asterix>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2001 at 11:42:23AM +0200, Christian Widmer wrote:
> so if i understood correctly you did your test only with that 3Com's that
> are your eth2@server (3Com PCI 3c905B) resp. eth0@client 
> (3Com PCI 3c905B). do you have another 3Com PCI 3c905B? 
> exchange one after the other and test again. i'had exactly the same 
> with some tulip NIS's when switching from a 10Mb to a 100Mb hub. 
> after exchanging one of the tulipNIS's it worked fine.

No, no spare 3com PCI cards whatsoever. I just tried a 3c595 but it
was stone dead. About to try an eepro100.

Thanks for the data point.
