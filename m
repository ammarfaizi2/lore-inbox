Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVCBSEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVCBSEo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbVCBSCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:02:01 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:3383 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262383AbVCBSBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:01:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VActDiJDZRBFVcXcJkOleNKVvmm/C3oeAB1U8vqHpEU4k+H2OBdgg5dTRfHn1AheNnDQ0bdsK4UgIR/xm3KXjw33BhJ7bUQBC6BSFYxZB3cKGG9iLSOs9lewYA0ihpcLdZfeHTnqN4leaSlqH8eaEthnltJtJyVbAsLmSFuCSRo=
Message-ID: <9e47339105030210012e98d658@mail.gmail.com>
Date: Wed, 2 Mar 2005 13:01:33 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Paul Mundt <lethal@linux-sh.org>, Adrian Bunk <bunk@stusta.de>,
       adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disallow modular framebuffers
In-Reply-To: <20050302121744.GA2871@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050301024118.GF4021@stusta.de>
	 <20050302121744.GA2871@linux-sh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 14:17:44 +0200, Paul Mundt <lethal@linux-sh.org> wrote:
> It seems more sensible to just fix up the drivers that don't do this
> right.. most of the broken drivers seem to be geared at x86 anyways where
> people generally don't seem to care.

X86 people don't care because they have VGA (with all of it's warts).
But that doesn't mean that VGA is a good thing. VGA lets X86 systems
run without needing framebuffer support.

-- 
Jon Smirl
jonsmirl@gmail.com
