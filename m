Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTE0RmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbTE0RlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:41:21 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:23046 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263986AbTE0RkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:40:04 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Date: Tue, 27 May 2003 19:52:34 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
References: <3ED2DE86.2070406@storadinc.com> <200305271936.34006.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305271447100.756@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305271952.34843.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 19:47, Marcelo Tosatti wrote:

Hi Marcelo,

> > A pause is _not_ perfectly fine, even not to some extent. That pause we
> > are discussing about is a pause of the _whole_ machine, not just disk i/o
> > pauses. Mouse stops, keyboard stops, everything stops, who knows wtf.
> Do you also notice them?
I do, people I know do also, numbers of those people only _I_ know are about 
~30. I've reported this problem over a year ago while 2.4.19-pre time.

> > That behaviour is absolutely bullshit for desktop users. For serverusage
> > you may not notice it in this dimension (mostly no X so no mouse), but
> > also for a server environment this may be very bad.
> Agreed.
thanks =)

ciao, Marc

