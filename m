Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264146AbTF0KhT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTF0KhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:37:18 -0400
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:48736 "EHLO
	mail.trasno.org") by vger.kernel.org with ESMTP id S264146AbTF0KhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:37:18 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <willy@debian.org>, David Woodhouse <dwmw2@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BINFMT_ZFLAT can't be a module
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@trasno.org>
In-Reply-To: <Pine.LNX.4.44.0306262105370.5042-100000@serv> (Roman Zippel's
 message of "Thu, 26 Jun 2003 21:10:49 +0200 (CEST)")
References: <20030626180909.GP451@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.44.0306262036030.11817-100000@serv>
	<20030626185659.GR451@parcelfarce.linux.theplanet.co.uk>
	<Pine.LNX.4.44.0306262105370.5042-100000@serv>
Date: Fri, 27 Jun 2003 12:51:30 +0200
Message-ID: <86of0jssi5.fsf@trasno.mitica>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "roman" == Roman Zippel <zippel@linux-m68k.org> writes:

Hi

roman> Expressions are documented and 'def_tristate ...' is short for 'tristate' 
roman> and 'default ...'

/me wonders if default_tristate or tristate_default will not be better
(it looks confusing with define_tristate).

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
