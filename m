Return-Path: <linux-kernel-owner+w=401wt.eu-S932078AbXARJJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXARJJ0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 04:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbXARJJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 04:09:26 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:20524 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXARJJZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 04:09:25 -0500
Message-ID: <45AF3942.9070701@fr.ibm.com>
Date: Thu, 18 Jan 2007 10:09:22 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]  Add new categories of DEPRECATED and OBSOLETE.
References: <Pine.LNX.4.64.0701171745480.4740@CPE00045a9c397f-CM001225dbafb6>
In-Reply-To: <Pine.LNX.4.64.0701171745480.4740@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   Next to EXPERIMENTAL, add two new kernel config categories of
> DEPRECATED and OBSOLETE.

What about adding some printks when DEPRECATED and OBSOLETE are 
set ? like in print_tainted() for example. 

C.
