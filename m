Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030697AbWHILdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030697AbWHILdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 07:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030699AbWHILdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 07:33:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19333 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030697AbWHILdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 07:33:38 -0400
Date: Wed, 9 Aug 2006 13:33:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -mm] NTP: Move all the NTP related code to ntp.c
In-Reply-To: <1155090945.13030.99.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0608091329180.6761@scrub.home>
References: <1155090945.13030.99.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 8 Aug 2006, john stultz wrote:

> Roman: I know you wanted me to hold off on this because you had NTP
> changes you were working on,

Oh, I meant this in regard to a possible reindentation. This OTOH should 
only require minimal patch editing. :)
My patches are mostly ready, I'll finish them in the evening.

bye, Roman
