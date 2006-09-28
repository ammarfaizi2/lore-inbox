Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWI1KVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWI1KVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031359AbWI1KVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 06:21:12 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:43985 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S1031297AbWI1KVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 06:21:11 -0400
Date: Thu, 28 Sep 2006 12:21:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Olaf Hering <olaf@aepfle.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add XARGS to toplevel Makefile
Message-ID: <20060928102100.GA27424@uranus.ravnborg.org>
References: <20060928060224.GA16290@aepfle.de> <Pine.LNX.4.61.0609281032420.21498@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609281032420.21498@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 10:33:01AM +0200, Jan Engelhardt wrote:
> >
> >run xargs with --no-run-if-empty to avoid random failures:
> 
> How about the short option, -r?
Is it more portable - otherwise the more descriptive option is preferred.

	Sam
