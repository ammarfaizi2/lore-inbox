Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271265AbRHXMvZ>; Fri, 24 Aug 2001 08:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271277AbRHXMvP>; Fri, 24 Aug 2001 08:51:15 -0400
Received: from ns.ithnet.com ([217.64.64.10]:18951 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S271265AbRHXMvC>;
	Fri, 24 Aug 2001 08:51:02 -0400
Date: Fri, 24 Aug 2001 14:50:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Upd: [PATCH NG] alloc_pages_limit & pages_min
Message-Id: <20010824145051.76f7859e.skraw@ithnet.com>
In-Reply-To: <200108241034.f7OAYPA07047@mailf.telia.com>
In-Reply-To: <Pine.LNX.4.33L.0108231600020.31410-100000@duckman.distro.conectiva>
	<200108231933.f7NJX8j21551@mailc.telia.com>
	<20010824112520.5f01626f.skraw@ithnet.com>
	<200108241034.f7OAYPA07047@mailf.telia.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2001 12:28:13 +0200
Roger Larsson <roger.larsson@skelleftea.mail.telia.com> wrote:

> Another thing to try is to run with non kernel nfs...

Sorry, probably can't do that. As far as I read the docs from reiser there is a problem with unfs on large reiser disks. If I got that right, it will not work anyway, even without this specific problem.

Regards, Stephan
