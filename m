Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269938AbUJSWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269938AbUJSWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269645AbUJSWS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:18:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269949AbUJSWER
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:04:17 -0400
Message-ID: <41758F53.80903@pobox.com>
Date: Tue, 19 Oct 2004 18:04:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml@lpbproductions.com
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Rate of change
References: <41758410.2020200@pobox.com> <200410191445.41292.lkml@lpbproductions.com>
In-Reply-To: <200410191445.41292.lkml@lpbproductions.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Heler wrote:
> How many changes occured between 2.6.8 & 2.6.9 ? 

'bk pull' says 4000 revisions to ChangeSet, for
15723 total revisions.

(these numbers include merge changesets, which inflate things)

