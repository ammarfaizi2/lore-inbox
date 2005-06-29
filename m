Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVF2BAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVF2BAR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVF2BAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:00:01 -0400
Received: from main.gmane.org ([80.91.229.2]:53434 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262348AbVF2Aig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 20:38:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: accessing loopback filesystem+partitions on a file
Date: Wed, 29 Jun 2005 00:30:32 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <d9sq37$kk1$1@sea.gmane.org>
References: <20050628233335.GB9087@lkcl.net>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl027-161-081.atl1.dsl.speakeasy.net
User-Agent: slrn/0.9.8.1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkcl@lkcl.net said:
> 	* how the hell do you loopback mount (or lvm mount
> 	  or _anything_! something!)  partitions that have
> 	  been created in a loopback'd file!!!!

use the offset option when mounting.

Jason

