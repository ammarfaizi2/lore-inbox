Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUIGP5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUIGP5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268343AbUIGPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:53:38 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:16358 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S268334AbUIGPwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:52:40 -0400
Date: Tue, 7 Sep 2004 17:52:40 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NULL dereference in OSS v_midi driver
Message-ID: <20040907155239.GE19354@MAIL.13thfloor.at>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200409011551.i81FpNha000690@delerium.codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409011551.i81FpNha000690@delerium.codemonkey.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 04:51:23PM +0100, Dave Jones wrote:
> Spotted with the source checker from Coverity.com.

apologies for the OT question:

how do you get the code checked with the source code
checker from Coverity.com? 

and would it be possible to have other kernel branches
or specific kernel patches checked too?

TIA,
Herbert

