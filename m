Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270273AbRHHCgi>; Tue, 7 Aug 2001 22:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270275AbRHHCg2>; Tue, 7 Aug 2001 22:36:28 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:65145 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S270273AbRHHCgS>; Tue, 7 Aug 2001 22:36:18 -0400
Date: Tue, 7 Aug 2001 22:36:25 -0400
From: Bill Nottingham <notting@redhat.com>
To: Stuart Lynne <sl@fireplug.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Message-ID: <20010807223625.A8330@nostromo.devel.redhat.com>
Mail-Followup-To: Stuart Lynne <sl@fireplug.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010807135135.J17723@fireplug.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010807135135.J17723@fireplug.net>; from sl@fireplug.net on Tue, Aug 07, 2001 at 01:51:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Lynne (sl@fireplug.net) said: 
> So not being able to reliable map ethernet devices to names is a feature
> not a bug .... 

With reasonable scriptage and 'nameif', it's doable. Only for
ethernet at the moment, however (and I haven't actually implementing
something that does this.)  But it *is* doable.

Bill
