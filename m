Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750998AbWB1OlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWB1OlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWB1OlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:41:15 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12515 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750978AbWB1OlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:41:14 -0500
Date: Tue, 28 Feb 2006 15:41:11 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Greg Smith <gsmith@nc.rr.com>
Subject: Re: 2.6.16-rc5-mm1
Message-ID: <20060228154111.63c5d95d@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060228042439.43e6ef41.akpm@osdl.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006 04:24:39 -0800
Andrew Morton <akpm@osdl.org> wrote:

> +s390-multiple-subchannel-sets-support-fix.patch

If neither Greg nor Martin (on cc:) object, I'd prefer this patch to be
replaced with the one in
http://marc.theaimsgroup.com/?l=linux-kernel&m=114102840429459&q=raw
(it has a better check of the response code).

Cornelia
