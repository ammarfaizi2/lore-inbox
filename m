Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264130AbUDVPSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264130AbUDVPSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUDVPSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:18:42 -0400
Received: from mx02.cybersurf.com ([209.197.145.105]:6811 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S264130AbUDVPSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:18:14 -0400
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: alex@pilosoft.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com>
References: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1082647046.1099.47.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Apr 2004 11:17:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 10:37, alex@pilosoft.com wrote:
> On 22 Apr 2004, jamal wrote:
> > Its infact harder to create this attack compared to a simple
> > SYN attack.
> Not quite. 

I meant a SYN Flood attack is a much trivial attack than this
but the media may have gotten used to it by now.

> > Unless i misunderstood: You need someone/thing to see about 64K packets
> > within a single flow to make the predicition so the attack is succesful.
> > Sure to have access to such capability is to be in a hostile path, no?
> > ;->
> No, you do not need to see any packet. 
> 

Ok, so i misunderstood then. How do you predict the sequences without
seeing any packet?
Is there any URL to mentioned paper?

> Inter-provider BGP is long-lived with close to fixed ports, which is why 
> it has caused quite a stir.

Makes sense. What would be the overall effect though? Route flaps?

> Nevertheless, number of packets to kill the session is still *large* 
> (under "best-case" for attacker, you need to send 2^30 packets)...

;->

cheers,
jamal

