Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUKFTrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUKFTrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 14:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbUKFTrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 14:47:45 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:56033 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261453AbUKFTrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 14:47:42 -0500
From: Daniel Drake <dsd@gentoo.org>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Missing SCSI command in the allowed list?
Date: Sat, 6 Nov 2004 16:24:57 +0000
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <cmikie$vif$1@sea.gmane.org>
In-Reply-To: <cmikie$vif$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411061624.57918.dsd@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 06 November 2004 13:47, Alexander E. Patrakov wrote:
> While cloning an audio CD using cdrdao 1.1.9 with vanilla linux-2.6.9 as a
> user, I see the following "errors":
>
> ERROR: Read buffer capacity failed.

I submitted a patch for this a few days ago. It has been merged into Linus's 
tree.

Daniel
