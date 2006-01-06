Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWAFTxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWAFTxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWAFTxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:53:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6916 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964817AbWAFTxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:53:38 -0500
Date: Fri, 6 Jan 2006 20:53:25 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brian Gerst <bgerst@didntduck.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gitignore shared objects
Message-ID: <20060106195325.GA16130@mars.ravnborg.org>
References: <43BD531C.3060801@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BD531C.3060801@didntduck.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 12:10:52PM -0500, Brian Gerst wrote:
> Many arches make shared objects for VDSOs.  Generally exclude them.
> 
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>

Applied. Bonus was to kill one .gitignore in x86_64.

	Sam
