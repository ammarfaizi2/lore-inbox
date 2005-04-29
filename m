Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262373AbVD2BwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVD2BwE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 21:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVD2BwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 21:52:03 -0400
Received: from smtp.istop.com ([66.11.167.126]:44230 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262373AbVD2Bvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 21:51:53 -0400
From: Daniel Phillips <phillips@istop.com>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 0/7] dlm: overview
Date: Thu, 28 Apr 2005 21:52:30 -0400
User-Agent: KMail/1.7
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org
References: <20050425151136.GA6826@redhat.com> <20050428145715.GA21645@marowsky-bree.de> <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504282152.31137.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 20:33, David Lang wrote:
> how is this UUID that doesn't need to be touched by an admin, and will
> always work in all possible networks (including insane things like backup
> servers configured with the same name and IP address as the primary with
> NAT between them to allow them to communicate) generated?
>
> there are a lot of software packages out there that could make use of
> this.

Please do not argue that the 32 bit node ID ints should be changed to uuids, 
please find another way to accommodate your uuids.

Regards,

Daniel
