Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWBZD41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWBZD41 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 22:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWBZD41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 22:56:27 -0500
Received: from i-216-58-89-227.gta.igs.net ([216.58.89.227]:2176 "EHLO
	mail.undead.cc") by vger.kernel.org with ESMTP id S1751145AbWBZD40
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 22:56:26 -0500
X-AuthUser: john@undead.cc
Message-ID: <440126E4.1030909@undead.cc>
Date: Sat, 25 Feb 2006 22:56:20 -0500
From: John Zielinski <john_ml@undead.cc>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: VIA Velocity massive memory corruption with jumbo frames
References: <43FFFB6B.7090700@undead.cc> <20060225235346.GA18558@electric-eye.fr.zoreil.com>
In-Reply-To: <20060225235346.GA18558@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Try the patch below and Cc: netdev@vger.kernel.org on further messages
> please.
>   
It worked.  No more memory corruption and I can ping 9000 byte packets 
to my Windows box.

