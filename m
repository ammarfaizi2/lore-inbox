Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWGLUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWGLUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWGLUX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:23:59 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:58326 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750835AbWGLUX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:23:58 -0400
Date: Wed, 12 Jul 2006 22:23:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: ricknu-0@student.ltu.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add include/linux/utsrelease.h to .gitignore
Message-ID: <20060712202357.GA16907@mars.ravnborg.org>
References: <1152732420.44b54d04db5c9@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152732420.44b54d04db5c9@portal.student.luth.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 09:27:00PM +0200, ricknu-0@student.ltu.se wrote:
> include/linux/utsrelease.h is created by Makefile and should be ignored by "git
> status".
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
Thanks.
I have a similar path in kbuild.git already.
Will appear in mainline within a week (if I finish of a few things so I
can push it.

	Sam
