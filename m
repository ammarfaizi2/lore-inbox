Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbTHSV7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTHSV7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:59:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:35589 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261388AbTHSV46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:56:58 -0400
Date: Tue, 19 Aug 2003 23:56:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@ravnborg.org, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild: Separate ouput directory support
Message-ID: <20030819215656.GE1791@mars.ravnborg.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
	akpm@ravnborg.org, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <20030819214144.GA30978@mars.ravnborg.org> <3F429C5D.4010201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F429C5D.4010201@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 05:53:33PM -0400, Jeff Garzik wrote:
> Is it possible, with your patches, to build from a kernel tree on a 
> read-only medium?

Yes, thats possible. But I have seen that as a secondary possibility.
But I know people has asked about the possibility to build a kernel
from src located on a CD. And thats possible with this patch.

	Sam
