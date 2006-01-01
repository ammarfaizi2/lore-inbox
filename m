Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWAAVZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWAAVZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 16:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWAAVZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 16:25:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8713 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932265AbWAAVZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 16:25:13 -0500
Date: Sun, 1 Jan 2006 22:25:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gitignore asm-offsets.h
Message-ID: <20060101212506.GA16444@mars.ravnborg.org>
References: <43B21238.2070409@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B21238.2070409@didntduck.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 11:19:04PM -0500, Brian Gerst wrote:
> Ignore asm-offsets.h for all arches.

Hi Brian.
I have applied all three gitignore patches to the kbuild tree.

	Sam
