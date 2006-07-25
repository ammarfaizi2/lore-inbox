Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbWGYWlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWGYWlc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWGYWlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:41:32 -0400
Received: from mail.gmx.net ([213.165.64.21]:65201 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932506AbWGYWlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:41:32 -0400
X-Authenticated: #271361
Date: Wed, 26 Jul 2006 00:41:27 +0200
From: Edgar Toernig <froese@gmx.de>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org, alan@redhat.com
Subject: Re: [PATCH 00/23] V4L/DVB fixes
Message-Id: <20060726004127.6eab5a9f.froese@gmx.de>
In-Reply-To: <20060725180311.PS54604900000@infradead.org>
References: <20060725180311.PS54604900000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:
>
> It contains the following stuff:
>[...]

I'm still missing the VBI_OFFSET fix.  See:

  http://marc.theaimsgroup.com/?m=114710558215044

Could you consider that patch for the next update and
IMHO also for 2.6.16.x and 2.6.17.x?  

Ciao, ET.
