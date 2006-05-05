Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWEEOJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWEEOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 10:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWEEOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 10:09:28 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51672 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751548AbWEEOJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 10:09:27 -0400
Message-ID: <445B5C8F.80302@sgi.com>
Date: Fri, 05 May 2006 16:09:19 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Brent Casavant <bcasavan@sgi.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] Move various PCI IDs to header file
References: <20060504180614.X88573@chenjesu.americas.sgi.com>
In-Reply-To: <20060504180614.X88573@chenjesu.americas.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Casavant wrote:
> Move various QLogic, Vitesse, and Intel storage
> controller PCI IDs to the main header file.
> 
> Signed-off-by: Brent Casavant <bcasavan@sgi.com>

Acked-by: Jes Sorensen <jes@sgi.com>

After all I tend to get the blame for the qla1280 driver.

Cheers,
Jes
