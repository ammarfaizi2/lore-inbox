Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265666AbTFZLTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 07:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265671AbTFZLTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 07:19:49 -0400
Received: from mail.ithnet.com ([217.64.64.8]:54535 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265666AbTFZLTt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 07:19:49 -0400
Date: Thu, 26 Jun 2003 13:34:15 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: willy@w.ods.org, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       kpfleming@cox.net, gibbs@scsiguy.com, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030626133415.4417e2e6.skraw@ithnet.com>
In-Reply-To: <16122.1630.134766.108510@gargle.gargle.HOWL>
References: <20030509150207.3ff9cd64.skraw@ithnet.com>
	<41560000.1055306361@caspian.scsiguy.com>
	<20030611222346.0a26729e.skraw@ithnet.com>
	<16103.39056.810025.975744@gargle.gargle.HOWL>
	<20030613114531.2b7235e7.skraw@ithnet.com>
	<20030625191655.GA15970@alpha.home.local>
	<20030625214221.2cd9613f.skraw@ithnet.com>
	<16122.1630.134766.108510@gargle.gargle.HOWL>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003 16:30:22 -0400
"John Stoffel" <stoffel@lucent.com> wrote:

> Maybe I need to try and generate 15-18 files 2gb+ each and dump them
> to tape with tar and see how that's handled, and if we get erorrs.

More data on this:
Today was a very bad day regarding the issue. I experienced three verification
errors, the filesizes were:

  563162975
  746555206
12679280738

So it seems it is not really linked to the filesize.

Regards,
Stephan

