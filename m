Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUASMPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 07:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUASMPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 07:15:24 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:28602 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264586AbUASMPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 07:15:23 -0500
To: Giuliano Pochini <pochini@shiny.it>
Cc: David Schwartz <davids@webmaster.com>, linux-kernel@vger.kernel.org,
       Misshielle Wong <mwl@bajoo.net>
Subject: Re: License question
References: <XFMail.20040119122403.pochini@shiny.it>
From: Jes Sorensen <jes@wildopensource.com>
Date: 19 Jan 2004 07:15:17 -0500
In-Reply-To: <XFMail.20040119122403.pochini@shiny.it>
Message-ID: <yq04qus878q.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Giuliano" == Giuliano Pochini <pochini@shiny.it> writes:

Giuliano> These are in fact the points I wished your opinion about...
Giuliano> Actually these are requirements (like others said), not use
Giuliano> restrictions. btw, IANAL and IP rights are a minefield.
Giuliano> Since their code is C++ I already rewote everything in C,
Giuliano> but it also contains the binary firmwares which I can't
Giuliano> rewrite. That's why I asked you about the license.  It's
Giuliano> likely Echoaudio will change the license in the next release
Giuliano> to a dual GPL/custom license, so this will be no more an
Giuliano> issue.

That sounds great, getting rid of the C++ components is a major step
;-)

Even if the firmware license doesn't change, you still have the option
to use the hotplug firmware loader in 2.6.

Cheers,
Jes
