Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWFNFIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWFNFIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWFNFIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:08:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:705 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964870AbWFNFIl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:08:41 -0400
To: Thomas Davis <tadavis@lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Athlon CPU detection/fixup is broken in 2.6.2-rc2
References: <401ACA49.8070002@lbl.gov>
From: Andi Kleen <ak@suse.de>
Date: 14 Jun 2006 07:08:39 +0200
In-Reply-To: <401ACA49.8070002@lbl.gov>
Message-ID: <p73odwwqq7c.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis <tadavis@lbl.gov> writes:

> I looked in the Changelog - who changed it?
> 
> It doesn't work on my dual athlon 2200 MP system - kills it dead.
> 
> I can get 2.6.2-rc1 to boot.

Very vague report. Modern kernel like 2.6.16 doesn't work? And where
does it crash exactly and in what way?

If you got it down to that release with binary search can you identify the
exact changeset that caused the problem? 

-Andi
