Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbUDOOrG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbUDOOrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 10:47:05 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:28022 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264252AbUDOOrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 10:47:04 -0400
Date: Thu, 15 Apr 2004 16:55:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dave Jones <davej@redhat.com>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Message-ID: <20040415145505.GA2229@mars.ravnborg.org>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org> <20040414170010.GA23419@redhat.com> <20040414202554.GA12020@mars.ravnborg.org> <20040415051215.GC1472@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040415051215.GC1472@himi.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixed the problem for me - 'make install modules_install'
> now does what it's supposed to do.

Thanks for the report.

	Sam
