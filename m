Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264923AbUGaHBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbUGaHBo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 03:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUGaHBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 03:01:43 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:42307 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S264923AbUGaHBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 03:01:42 -0400
Date: Sat, 31 Jul 2004 09:02:37 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Johannes Stezenbach <js@convergence.de>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>, Pavel Roskin <proski@gnu.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] modpost warnings with external modules w/o modversions
Message-ID: <20040731070237.GA6989@mars.ravnborg.org>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@germaschewski.name>,
	Sam Ravnborg <sam@ravnborg.org>, Pavel Roskin <proski@gnu.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040719125106.GA29131@convergence.de> <20040719145911.GA7007@mars.ravnborg.org> <20040719173610.GB1987@convergence.de> <20040730224131.GA18686@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730224131.GA18686@convergence.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 31, 2004 at 12:41:31AM +0200, Johannes Stezenbach wrote:
> 
> Is there any chance that this patch could go into mainline kernel
> anytime soon? It seems that this isn't even in bk-kbuild that
> went into 2.6.8-rc2-mm1.

It's an oversight that it was not included.
It will be there in next round of kbuild patches.

	Sam
