Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131282AbRCNDBS>; Tue, 13 Mar 2001 22:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131281AbRCNDA6>; Tue, 13 Mar 2001 22:00:58 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:32758 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S131279AbRCNDAr>;
	Tue, 13 Mar 2001 22:00:47 -0500
Date: Tue, 13 Mar 2001 23:30:34 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: James Stevenson <mistral@stev.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: VM problem with 2.2.18 ?
In-Reply-To: <Pine.LNX.4.21.0103132323450.18168-100000@cyrix.home>
Message-ID: <Pine.LNX.4.21.0103132329500.2056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, James Stevenson wrote:

>  VM: do_try_to_free_pages failed for ypbind...

Known problem. It is fixed in 2.2.19-pre3 and newer.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

