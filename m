Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264792AbTFLNlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 09:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264796AbTFLNlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 09:41:39 -0400
Received: from mail.ithnet.com ([217.64.64.8]:37132 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264792AbTFLNli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 09:41:38 -0400
Date: Thu, 12 Jun 2003 15:54:45 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Cc: gibbs@scsiguy.com, willy@w.ods.org, marcelo@conectiva.com.br,
       green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030612155445.7a023a04.skraw@ithnet.com>
In-Reply-To: <20030611222346.0a26729e.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jun 2003 22:23:46 +0200
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> Hello,
> [...]
> Anyway it looks like failures have gotten fewer since rc8. I will try an
> overnight stress test now to see if I get it freezing again.

Interestingly it does not freeze. One file shows data corruption, but the
system looks stable. None of the older rc's made it up to this point. Looks
like something in rc8 got better and I am in fact experiencing a set of bugs
and not only one.

Regards,
Stephan

