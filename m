Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVE3Oy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVE3Oy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVE3OxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:53:11 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:16272 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261622AbVE3Owv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:52:51 -0400
Message-ID: <429B289D.7070308@nortel.com>
Date: Mon, 30 May 2005 08:52:13 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Kyle Moffett <mrmacman_g4@mac.com>, john cooper <john.cooper@timesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: spinaphore conceptual draft
References: <934f64a205052715315c21d722@mail.gmail.com>	<A53A981B-98F9-42EC-8939-60A528FEC34E@mac.com> <m1r7fpvupa.fsf@muc.de>
In-Reply-To: <m1r7fpvupa.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> On many architectures (including popular ones like AMD x86-64) 
> there is no reliable fast monotonic (1) count unfortunately 

What about rdtsc?

Chris
