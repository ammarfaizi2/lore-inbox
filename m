Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268868AbUIHGRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268868AbUIHGRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268873AbUIHGRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:17:45 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:36464 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268868AbUIHGRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:17:44 -0400
Date: Wed, 8 Sep 2004 10:17:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
       Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] 2.6.9-rc1-mm4: Makefile: remove tabs from empty lines
Message-ID: <20040908081752.GA8509@mars.ravnborg.org>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
References: <20040907020831.62390588.akpm@osdl.org> <20040907190212.GB2454@fs.tum.de> <20040907211422.GA6053@mars.ravnborg.org> <200409080051.03548.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409080051.03548.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 12:51:02AM -0500, Dmitry Torokhov wrote:
> On Tuesday 07 September 2004 04:14 pm, Sam Ravnborg wrote:
> > Amyways I try to avoid these, but my gvim is pretty consistent in adding
> > additional tabs/spaces here and there. Anyone that can tell me how to
> > teach gvim not to do so (and flag trailing tabs/spaces).
> 
> I have the following in my .vimrc:
> 
> highlight WhitespaceEOL ctermbg=red guibg=red
> match WhitespaceEOL /\s\+$/
Added - thanks.

	Sam
