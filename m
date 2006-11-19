Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756494AbWKSHfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494AbWKSHfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 02:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756495AbWKSHfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 02:35:30 -0500
Received: from main.gmane.org ([80.91.229.2]:59536 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1756494AbWKSHf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 02:35:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] Fix unprivileged user builds of initramfs
Date: Sun, 19 Nov 2006 07:35:17 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnem02n9.fp5.olecom@flower.upol.cz>
References: <20061119050028.GF18567@parisc-linux.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-19, Matthew Wilcox wrote:
[]
> Someone with more time might find a more elegant fix for either or both
> of these problems.  But now my qlogic adapter can find its firmware without
> being turned into a module.

Please check "initramfs-handle-more-than-one-source-dir-or-file-list.patch"
in mm.

____

