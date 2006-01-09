Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWAISOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWAISOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964906AbWAISOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:14:04 -0500
Received: from amdext4.amd.com ([163.181.251.6]:19843 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S964907AbWAISOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:14:03 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Mon, 9 Jan 2006 11:21:54 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-usb-devel@lists.sourceforge.net
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       info-linux@ldcmail.amd.com, thomas.dahlmann@amd.com
Subject: Re: UDC support for MIPS/AU1200 and Geode/CS5536
Message-ID: <20060109182154.GL17575@cosmic.amd.com>
References: <20060109180356.GA8855@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20060109180356.GA8855@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDC78353982717051-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/06 11:03 -0700, Jordan Crouse wrote:

> From the "two-birds-one-stone" department, I am pleased to present USB UDC
> support for both the MIPS Au1200 SoC and the Geode CS5535 south bridge.  
                                                     ^^^^^^
Of course, I meant the CS5536 - this *won't* work for the CS5535.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

