Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267219AbUBMVDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 16:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267215AbUBMVCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 16:02:45 -0500
Received: from sun.barak.net.il ([212.150.48.119]:24995 "EHLO
	sun.barak-online.net") by vger.kernel.org with ESMTP
	id S267214AbUBMVCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 16:02:21 -0500
From: aviv bergman <bergmana@barak-online.net>
To: linux-kernel@vger.kernel.org
Subject: Re: is nForce2 good choice under Linux?
Date: Fri, 13 Feb 2004 23:01:45 +0200
User-Agent: KMail/1.6
References: <Pine.LNX.4.58.0402132048330.31906@alpha.polcom.net> <402D3448.7080105@reactivated.net>
In-Reply-To: <402D3448.7080105@reactivated.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402132301.45324.bergmana@barak-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 22:32, Daniel Drake wrote:
> I have been perfectly happy with my NF7-S, except from the one time it
> failed on me (didn't boot up), and I had to get it replaced. I think there
> is a general risk involved in buying nforce2 boards, their rate of failure
> is fairly high. Still, the benefits are nice.

the shuttle FN41 (sn41g2 xpc) is probably safe - i had very frequent lockups 
after upgrading to 2.6.0, flashed to the latest bios, and the system is rock 
stable since (2.6.1 w/apic)

you better check if the specific board you are going to buy has a fixed bios.

aviv
