Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWCENwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWCENwk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 08:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWCENwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 08:52:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:58829 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932076AbWCENwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 08:52:40 -0500
Date: Sun, 5 Mar 2006 14:52:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Daniel Drake <dsd@gentoo.org>
cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, okir@monad.swb.de
Subject: Re: [PATCH] sunrpc svc: be quieter
In-Reply-To: <20060305005532.5E7A0870504@zog.reactivated.net>
Message-ID: <Pine.LNX.4.61.0603051451590.30115@yvahk01.tjqt.qr>
References: <20060305005532.5E7A0870504@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>A Gentoo user at http://bugs.gentoo.org/124884 reports that the following
>message appears in the logs over 650 times every day:
>
>	svc: unknown version (0)
>
Should not the clients be fixed?


Jan Engelhardt
-- 
