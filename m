Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752217AbWCFIpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbWCFIpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbWCFIpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:45:14 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:42701 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752217AbWCFIpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:45:12 -0500
Date: Mon, 6 Mar 2006 09:45:09 +0100
From: Cornelia Huck <huckc@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm2
Message-ID: <20060306094509.3427748a@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060303045651.1f3b55ec.akpm@osdl.org>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2006 04:56:51 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Changes since 2.6.16-rc5-mm1:
...
> -s390-multiple-subchannel-sets-support-fix.patch
> 
>  Merged

Not in my copy of the git tree at least :)

Either this patch or (preferrably) the patch in
http://marc.theaimsgroup.com/?l=linux-kernel&m=114102840429459&q=raw
should be merged for 2.6.16 so that users on old machines or on
hercules aren't grieved...

Cornelia
