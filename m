Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbVKFWqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVKFWqG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVKFWqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:46:06 -0500
Received: from [81.2.110.250] ([81.2.110.250]:14984 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751262AbVKFWqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:46:04 -0500
Subject: Re: [PATCH] Base support patch for the AMD Geode GX/LX processors.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jordan Crouse <jordan.crouse@AMD.com>
Cc: linux-kernel@vger.kernel.org, info-linux@ldcmail.amd.com
In-Reply-To: <20051105213433.GA25326@cosmic.amd.com>
References: <20051105213433.GA25326@cosmic.amd.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Nov 2005 23:16:33 +0000
Message-Id: <1131318993.1212.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-05 at 14:34 -0700, Jordan Crouse wrote:
> Base support patch for the AMD Geode GX/LX processors.  Changes
> from previous patch:
> 
> * Add GEODE_LX back to the CONFIG_3DNOW and CONFIG_PPRO_CHECKSUM options
>   after tests revealed that both options were beneficial.
> * Move changes from Kconfig to Kconfig.cpu
> 
> Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

Acked-by: Alan Cox <alan@redhat.com>

