Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWEAPVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWEAPVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 11:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWEAPVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 11:21:40 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:45466 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932122AbWEAPVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 11:21:40 -0400
Date: Mon, 1 May 2006 08:21:37 -0700
From: Chris Wedgwood <cw@f00f.org>
To: David Greaves <david@dgreaves.com>
Cc: Nathan Scott <nathans@sgi.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, nickpiggin@yahoo.com.au
Subject: Re: Bad page state in process 'nfsd' with xfs
Message-ID: <20060501152137.GB24771@taniwha.stupidest.org>
References: <4452797F.70700@dgreaves.com> <20060501080427.H1771752@wobbly.melbourne.sgi.com> <4455D7E7.1040203@dgreaves.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4455D7E7.1040203@dgreaves.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 10:41:59AM +0100, David Greaves wrote:

> It's in use a lot so I'll schedule some downtime, blow out the dust
> and run memtest (though I've done that before and it has been
> clean).

memtest doesn't always find bad memory sadly

finding bad memory is hard, and sometimes it's exacerbated by
complicated factors (heat from drives for example)

i wish ecc memory was standard

