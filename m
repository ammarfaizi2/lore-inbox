Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274888AbTHFK1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274909AbTHFK1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:27:06 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:13020 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S274888AbTHFK1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:27:03 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 6 Aug 2003 12:27:01 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: decoded problem in 2.4.22-pre10
Message-Id: <20030806122701.79c609b4.skraw@ithnet.com>
In-Reply-To: <943FB181AFA@vcnet.vc.cvut.cz>
References: <943FB181AFA@vcnet.vc.cvut.cz>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 14:46:52 +0200
"Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:

> On  5 Aug 03 at 14:23, Stephan von Krawczynski wrote:
> > 
> > Hello Petr,
> > [...]
> > And frankly: I find the application quite ok but tainting the kernel with
> > the closed source modules is really something to think about, especially
> > since there should be easy ways to avoid that completely.
> 
> This is not true. VMware modules are open source, they are just non-GPL.

Sorry for my incorrect description of what I really meant. In fact I wanted to
express that the _tainting_ (obviously meaning lack of GPL licensing) should be
thought about.

Regards,
Stephan
