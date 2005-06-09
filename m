Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262369AbVFIMQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbVFIMQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262368AbVFIMQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:16:53 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:710 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262370AbVFIMQd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:16:33 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Thu, 9 Jun 2005 14:16:38 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: Frederik Deweerdt <dev.deweerdt@laposte.net>, linux-kernel@vger.kernel.org
Subject: Re: [TTY] exclusive mode question
Message-ID: <20050609121638.GD507@gilgamesh.home.res>
Mail-Followup-To: moreau francis <francis_moreau2000@yahoo.fr>,
	Frederik Deweerdt <dev.deweerdt@laposte.net>,
	linux-kernel@vger.kernel.org
References: <20050609104140.GB507@gilgamesh.home.res> <20050609114149.60315.qmail@web25807.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050609114149.60315.qmail@web25807.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/06/05 13:41 +0200, moreau francis écrivit:
> 
> oh ok...sorry I misunderstood TIOEXCL meaning ;)
> Do you know how I could implement such exclusive mode (the one I described) ?
> 
This is handled through lock files, google for LCK..ttyS0
Regards,
Frederik Deweerdt
