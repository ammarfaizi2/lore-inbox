Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262536AbSIPQK4>; Mon, 16 Sep 2002 12:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262544AbSIPQK4>; Mon, 16 Sep 2002 12:10:56 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39366 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262536AbSIPQKz>; Mon, 16 Sep 2002 12:10:55 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209161615.g8GGFqx10004@devserv.devel.redhat.com>
Subject: Re: [PATCH] Summit patch for 2.5.34
To: davej@suse.de (Dave Jones)
Date: Mon, 16 Sep 2002 12:15:52 -0400 (EDT)
Cc: jamesclv@us.ibm.com (James Cleverdon), linux-kernel@vger.kernel.org,
       James.Bottomley@steeleye.com, torvalds@transmeta.com, alan@redhat.com,
       mingo@redhat.com
In-Reply-To: <20020916175545.A21875@suse.de> from "Dave Jones" at Sep 16, 2002 05:55:45 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Is this the same summit code as is in 2.4-ac ?
>   (Ie, the one that boots on non summit systems too)

Yes

> - I believe the way forward here is to work with James Bottomley,
>   who has a nice abstraction of the areas your patch touches for
>   his Voyager sub-architecture.

For 2.5 maybe not for 2.4. Until Linus takes the subarch stuff the 
if if if bits will just get uglier. As well as voyager there are at least
two more pending NUMA x86 platforms other than IBM summit
