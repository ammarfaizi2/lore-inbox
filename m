Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291306AbSCOLiN>; Fri, 15 Mar 2002 06:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291258AbSCOLh5>; Fri, 15 Mar 2002 06:37:57 -0500
Received: from angband.namesys.com ([212.16.7.85]:31105 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S291251AbSCOLhI>; Fri, 15 Mar 2002 06:37:08 -0500
Date: Fri, 15 Mar 2002 14:37:04 +0300
From: Oleg Drokin <green@namesys.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-ID: <20020315143704.A2086@namesys.com>
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com> <15499.64058.442959.241470@charged.uio.no> <20020311091458.A24600@namesys.com> <20020311114654.2901890f.skraw@ithnet.com> <20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com> <20020315141328.A1879@namesys.com> <20020315123008.14237953.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020315123008.14237953.skraw@ithnet.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Mar 15, 2002 at 12:30:08PM +0100, Stephan von Krawczynski wrote:

> Very low. Something like 10 MB reading files on the server. My standard way of producing it is mounting the backup fs and then starting yast (SuSE config tool), which is configured to read the data from (the same) nfs-server. Scroll around in the packet selection a bit and exit the tool without installing something. I cannot see however how YaST mounts the fs (which options on mount command). Maybe someone from SuSE can clarify?

Well, I tried with the options you provided and still no luck.

Bye,
    Oleg
