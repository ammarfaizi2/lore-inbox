Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVEKEyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVEKEyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 00:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVEKEyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 00:54:21 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:35413 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261874AbVEKEyT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 00:54:19 -0400
Date: Wed, 11 May 2005 06:55:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc4
Message-ID: <20050511045538.GB8025@mars.ravnborg.org>
References: <Pine.LNX.4.58.0505062245160.2233@ppc970.osdl.org> <4280A1E5.8000601@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4280A1E5.8000601@grupopie.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a known bug that the attached patch by Sam Ravnborg fixes.
> 
> I really don't know if this is the proper fix or not. Maybe Sam (CC'ed)
> can say better if this is more of a band aid or the correct solution.

This patch ought to be applied. It was missed by accident in my last
batch of patches.
I will forward it to Linus when Linus is back.

	Sam
