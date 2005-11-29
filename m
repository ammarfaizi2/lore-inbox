Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVK2UgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVK2UgM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVK2UgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:36:12 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:8055 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S932390AbVK2UgK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:36:10 -0500
Date: Tue, 29 Nov 2005 21:36:22 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       jbglaw@lug-owl.de, torvalds@osdl.org
Subject: Re: [PATCH 2.6.15-rc2-git6] Fix tar-pkg target
Message-ID: <20051129203622.GA17053@mars.ravnborg.org>
References: <20051128170414.GA10601@harddisk-recovery.nl> <20051129133042.6d344110.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129133042.6d344110.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> I already have the below queued up, which is a bit different.  Does it work
> OK?

Brian's version preserve EXTRANAME, but I have not seen it
used/documented anywhere?

	Sam
