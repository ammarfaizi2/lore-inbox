Return-Path: <linux-kernel-owner+w=401wt.eu-S1754780AbWL2Gbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbWL2Gbb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 01:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754827AbWL2Gbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 01:31:31 -0500
Received: from mx10.go2.pl ([193.17.41.74]:54232 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754780AbWL2Gba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 01:31:30 -0500
Date: Fri, 29 Dec 2006 07:32:55 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 and up to  2.6.20-rc2 Ethernet problems x86_64
Message-ID: <20061229063254.GA1628@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459338AF.6010200@blueyonder.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-12-2006 04:23, Sid Boyce wrote:
> 
> 
> I first saw the problem on the 64x2 box after upgrading to 2.6.19. The
> network appeared OK with ifconfig and route -n, but I had no network
> access. Pinging any other box, the box was responding, but no response
...
> barrabas:/usr/src/linux-2.6.20-rc1-git5 # ssh Boycie ifconfig
> Password:
> eth0      Link encap:Ethernet  HWaddr 00:0A:E4:4E:A1:42
>           inet addr:192.168.10.5  Bcast:255.255.255.255  Mask:255.255.255.0

This Bcast isn't probably what you need.

Regards,
Jarek P.
