Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUHVPqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUHVPqL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUHVPqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:46:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:1189 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267469AbUHVPqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:46:08 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8.1-mm3
Date: Sun, 22 Aug 2004 08:44:55 -0700
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       John Hawkes <hawkes@sgi.com>
References: <20040820031919.413d0a95.akpm@osdl.org> <200408211827.46591.jbarnes@engr.sgi.com> <412800D6.3070207@yahoo.com.au>
In-Reply-To: <412800D6.3070207@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408220844.55618.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 21, 2004 7:11 pm, Nick Piggin wrote:
> I don't see it - what function are you talking about?

Nevermind, I was misreading it last night.  I thought that the group spanning 
code would create spans bigger than the domain they were associated with, but 
it looks like they'll be ok.

Jesse
