Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVADQZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVADQZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVADQZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 11:25:06 -0500
Received: from [213.146.154.40] ([213.146.154.40]:14208 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261716AbVADQXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 11:23:35 -0500
Date: Tue, 4 Jan 2005 16:23:23 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [bk patches] Long delayed input update
Message-ID: <20050104162323.GA2550@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20041227142821.GA5309@ucw.cz> <200412271419.46143.dtor_core@ameritech.net> <20050103131848.GH26949@ucw.cz> <Pine.LNX.4.58.0501032148210.2294@ppc970.osdl.org> <20050104135859.GA9167@ucw.cz> <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501040756230.2294@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 07:58:50AM -0800, Linus Torvalds wrote:
> Ahh. It's a G5 mac, so I guess it isn't needed. Even so, that thing 
> shouldn't show up. If I don't have AT keyboard _or_ mouse selected, it 
> shouldn't be there - they should "select" it, and if nothing uses it, then 
> there isn't anything to do. In no case should it show up as a question.

Compiling in PC keyboard controller support will actually crash your
shiny G5 mac ;-)

