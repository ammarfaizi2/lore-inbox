Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964938AbVJZVjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVJZVjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 17:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbVJZVjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 17:39:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:34948 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964938AbVJZVjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 17:39:13 -0400
From: Andi Kleen <ak@suse.de>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Date: Wed, 26 Oct 2005 23:39:36 +0200
User-Agent: KMail/1.8.2
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
References: <20051026070956.GA3561@localhost.localdomain> <200510261646.26331.ak@suse.de> <20051026202017.GA3841@localhost.localdomain>
In-Reply-To: <20051026202017.GA3841@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510262339.37326.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 October 2005 22:20, Ravikiran G Thirumalai wrote:

> How's this?

Looks good.

There is a small inaccuracy in the help text for K8 - dual core single
socket systems don't need NUMA - but I can fix that.

-Andi
