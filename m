Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263367AbTJBOe5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJBOe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:34:57 -0400
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:15029 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263367AbTJBOez
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:34:55 -0400
Message-ID: <3F7C373D.7070409@stesmi.com>
Date: Thu, 02 Oct 2003 16:33:33 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Jonathan Brown <jbrown@emergence.uk.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: What Processor family for Centrino Pentium M?
References: <1065032627.9643.57.camel@localhost> <16251.10643.891947.130552@gargle.gargle.HOWL>
In-Reply-To: <16251.10643.891947.130552@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikael.

>  > Is the Pentium M a P3 or a P4? What should I set in my kernel config?
> 
> Pentium III.

Isn't it based on the P4 ? It uses the same quad pumped bus at the P4
and has SSE2 for instance. Both of those are lacking on the P3.

// Stefan

