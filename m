Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWIDVb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWIDVb2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbWIDVb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:31:28 -0400
Received: from main.gmane.org ([80.91.229.2]:32969 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964979AbWIDVb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:31:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andras Mantia <amantia@kde.org>
Subject: Re: PATA drivers queued for 2.6.19
Followup-To: gmane.linux.ide
Date: Tue, 05 Sep 2006 00:31:00 +0300
Message-ID: <edi5uq$o4i$1@sea.gmane.org>
References: <44FC0779.9030405@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 84.247.48.183
User-Agent: KNode/0.10.4
Cc: linux-ide@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> 
> I just pulled the "pata-drivers" branch of libata-dev.git into the
> "upstream" branch, which means that Alan's libata PATA driver collection
> is now queued for 2.6.19.
> 
> Testing-wise, these PATA drivers have been Andrew Morton's -mm tree for
> many months.  Community-wise, no one posted objections to the PATA
> driver merge plan, when Alan posted it on LKML and linux-ide.

Does this include the patch to support the PATA port on the promise
controllers (described here
https://bugzilla.novell.com/show_bug.cgi?id=176249 ) ?

Andras
-- 
Quanta Plus developer - http://quanta.kdewebdev.org
K Desktop Environment - http://www.kde.org


