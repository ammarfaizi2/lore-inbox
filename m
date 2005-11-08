Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVKHOTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVKHOTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVKHOTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:19:14 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40773
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965213AbVKHOTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:19:13 -0500
Message-Id: <4370C22B.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:20:11 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] provide stricmp
References: <4370AF1E.76F0.0078.0@novell.com> <20051108134121.GA15406@infradead.org>
In-Reply-To: <20051108134121.GA15406@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Christoph Hellwig <hch@infradead.org> 08.11.05 14:41:21 >>>
>On Tue, Nov 08, 2005 at 01:58:54PM +0100, Jan Beulich wrote:
>> While strnicmp existed in the set of string support routines,
stricmp
>> didn't, which this patch adjusts.
>
>There's still no user.  Please stop blindly resubmitting things that
>have been rejected.

Consistency or anything similar doesn't count?

Jan

