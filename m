Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131817AbRCOTrD>; Thu, 15 Mar 2001 14:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131818AbRCOTq4>; Thu, 15 Mar 2001 14:46:56 -0500
Received: from raven.toyota.com ([63.87.74.200]:22533 "EHLO raven.toyota.com")
	by vger.kernel.org with ESMTP id <S131817AbRCOTqq>;
	Thu, 15 Mar 2001 14:46:46 -0500
Message-ID: <3AB11BF7.32FEF442@toyota.com>
Date: Thu, 15 Mar 2001 11:45:59 -0800
From: J Sloan <jjs@toyota.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gregory Maxwell <greg@linuxpower.cx>
CC: Rik van Riel <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
In-Reply-To: <Pine.LNX.4.33.0103152304570.1320-100000@duckman.distro.conectiva> <3AB1153F.802BEBA9@toyota.com> <20010315143611.E30509@xi.linuxpower.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:

> The scheduler schedules tasks not interrupts. Unless it manages to thrash the
> cache, the scheduler can not affect routing performance.

OK, thanks for the clarification - I need to get into the source.

cu

Jup

