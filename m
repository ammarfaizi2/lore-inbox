Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291192AbSBZQqs>; Tue, 26 Feb 2002 11:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291245AbSBZQqi>; Tue, 26 Feb 2002 11:46:38 -0500
Received: from ns.ithnet.com ([217.64.64.10]:17682 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S291192AbSBZQq2>;
	Tue, 26 Feb 2002 11:46:28 -0500
Date: Tue, 26 Feb 2002 17:46:02 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
Message-Id: <20020226174602.4f4b30bc.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva>
In-Reply-To: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101FE2@nocmail.ma.tmpw.net>
	<Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002 16:18:46 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> [...]
> The patch which I missed only breaks static apps on _some_ architectures
> (not including x86).

This statement is not very nice. You obviously classify these architectures as minor important. At least not important enough to give them a release version as bugfree as possible at the given time. You shouldn't do that, don't focus on what you classify the "mainstream" too much. 
As stated before, there is no problem with making mistakes. You only have to handle the situation in an intelligent manner _and_ aware of the power given to you. 
In my eyes, the clean choice would have been 2.4.19 release.

> > Some people may get confused grabbing 2.4.18 and not getting the fixes
> > that went into rc-4? Just a thought...
> 
> I already changed ftp.kernel.org's changelog adding:
> 
> "Update: The SET_PERSONALITY fix in rc4 has _not_ 
> been included in the final 2.4.18 by mistake."
> 
> I guess thats enough.

Technically correct, but intentionally questionable.

Regards,
Stephan

