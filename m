Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVKTMWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVKTMWS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 07:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVKTMWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 07:22:18 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:45837 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751223AbVKTMWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 07:22:18 -0500
Message-ID: <43806A4E.1070401@shadowen.org>
Date: Sun, 20 Nov 2005 12:21:34 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kravetz@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 3/3] sparse provide pfn_to_nid
References: <exportbomb.1132181992@pinky>	<20051116230023.GA16493@shadowen.org> <20051119233151.01ce6c50.akpm@osdl.org>
In-Reply-To: <20051119233151.01ce6c50.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> It's a big mess - can someone please fix it up?  The maze of config options
> is just over the top.
> 
> Meanwhile, I'll drop this patch.

Gack, agreed this is all a mess.  I'll take care of it.

-apw
