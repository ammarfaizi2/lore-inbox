Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262954AbUJ0W2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUJ0W2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUJ0WZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:25:23 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:52428 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262902AbUJ0WW6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:22:58 -0400
Date: Thu, 28 Oct 2004 00:19:41 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
Message-ID: <20041027221941.GA20196@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.61.0410250645540.9868@p500> <417CE49B.4060308@yahoo.com.au> <Pine.LNX.4.61.0410271733440.10927@p500> <20041027145806.4e7acea3.akpm@osdl.org> <Pine.LNX.4.61.0410271754280.10927@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410271754280.10927@p500>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz <jpiszcz@lucidpixels.com> :
[...]
> I do not explicitly set ethtool* tso, however I use dhcpcd on this 
> interface, does that set TSO on the interface? I have never used TSO (that 

Hint: ethtool -k ethX

--
Ueimor
