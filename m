Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWCIPDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWCIPDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbWCIPDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:03:17 -0500
Received: from dvhart.com ([64.146.134.43]:2481 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751835AbWCIPDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:03:16 -0500
Message-ID: <441043AD.2000609@mbligh.org>
Date: Thu, 09 Mar 2006 07:03:09 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.16-rc5-mm3
References: <20060307021929.754329c9.akpm@osdl.org>	<440DEF0A.3030701@mbligh.org>	<440DEF75.9060802@mbligh.org> <20060307125122.5f7d3462.akpm@osdl.org>
In-Reply-To: <20060307125122.5f7d3462.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> No, it's just that we suck.  The numa-maps update got squeezed in at the
> last minute.
> 
> I guess we do it this way - there's still code in there which will call
> check_huge_range(), but it's inside if (0) {}.

Works as of -git12.

Thanks!

M.

