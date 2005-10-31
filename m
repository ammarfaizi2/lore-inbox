Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbVJaPen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVJaPen (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVJaPen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:34:43 -0500
Received: from amdext4.amd.com ([163.181.251.6]:52441 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932161AbVJaPem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:34:42 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Mon, 31 Oct 2005 08:37:15 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
Subject: Re: AMD Geode GX/LX Support (Refreshed)
Message-ID: <20051031153715.GE20777@cosmic.amd.com>
References: <LYRIS-4270-74122-2005.10.28-09.38.17--jordan.crouse#amd.com@whitestar.amd.com>
 <20051028154430.GB19854@cosmic.amd.com>
 <1130711970.32734.13.camel@localhost.localdomain>
MIME-Version: 1.0
In-Reply-To: <1130711970.32734.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F78E60935K3817125-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does this mean you've now done actual performance analysis on whether
> this is a good idea for Geode GX/LX ?


I'm fairly sure that the ppro checksum is faster, but you're exactly right,
we should publish some numbers.  Mia culpa.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

