Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWEKPGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWEKPGi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWEKPGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:06:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34790 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751832AbWEKPGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:06:38 -0400
To: "Ed White" <ed.white@libero.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SecurityFocus Article
References: <20060511143440.23517.qmail@securityfocus.com>
From: Andi Kleen <ak@suse.de>
Date: 11 May 2006 17:06:34 +0200
In-Reply-To: <20060511143440.23517.qmail@securityfocus.com>
Message-ID: <p73mzdo7g91.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ed White" <ed.white@libero.it> writes:

> A researcher of the french NSA discovered a scary vulnerability in modern x86 cpus and chipsets that expose the kernel to direct tampering.
> 

It's nothing new really. Similar attacks have been known and discussed
in theory for years.

>From a security perspective X server and anything else with direct
hardware access is essentially part of the kernel.

-Andi
