Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266680AbUJPT2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266680AbUJPT2Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbUJPT2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:28:14 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:4990 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S266680AbUJPT2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:28:01 -0400
Date: Sat, 16 Oct 2004 23:27:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mention that DEBUG_SLAB can slow down machine quite a bit
Message-ID: <20041016212756.GB8765@mars.ravnborg.org>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200409161132.05247.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409161132.05247.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:32:04AM +0300, Denis Vlasenko wrote:
> Hi,
> 
> I experienced x3 slowdown due to this option being set.
> 
> Please add this small warning to DEBUG_SLAB help text.
> --
> vda

Applied.

	Sam
