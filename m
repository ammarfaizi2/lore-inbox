Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUIOBYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUIOBYl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUIOBYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:24:41 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:50351 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266810AbUIOBYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:24:40 -0400
Message-ID: <414799D1.7050609@nortelnetworks.com>
Date: Tue, 14 Sep 2004 19:24:33 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Anton Blanchard <anton@samba.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
References: <41474B15.8040302@nortelnetworks.com> <20040915002023.GD5615@krispykreme> <119340000.1095209242@flay>
In-Reply-To: <119340000.1095209242@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:

> If the changes are in fairly independant files, just vi'ing the diff is
> normally very effective. If they're all intertangled, then starting again
> from scratch is prob easier ;-)

Unfortunately I've got over 550 files being changed, in probably about 50 
conceptual areas.

It's not going to be fun.

Chris
