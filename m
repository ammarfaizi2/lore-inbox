Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264112AbTLAXrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 18:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264258AbTLAXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 18:47:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56070
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264112AbTLAXri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 18:47:38 -0500
Date: Mon, 1 Dec 2003 15:47:32 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Rootkit queston
Message-ID: <20031201234732.GL1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: M?ns Rullg?rd <mru@kth.se>, linux-kernel@vger.kernel.org
References: <1070313094.11356.6.camel@midux> <Pine.LNX.4.53.0312011649060.4785@chaos> <yw1xisl0un4o.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xisl0un4o.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 12:36:07AM +0100, M?ns Rullg?rd wrote:
> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> >> They seem to have PID 0, is this normal?
> >
> > Yes. These are kernel threads.
> 
> That doesn't necessarily rule out the possibility of them being evil.
> If someone has taken control of the system, he could have loaded some
> module that started a thread disguising itself under a common name.

True, but it would make the thread invisible if they were going to do that...
