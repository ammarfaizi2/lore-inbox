Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131232AbRCMXHB>; Tue, 13 Mar 2001 18:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRCMXGl>; Tue, 13 Mar 2001 18:06:41 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:50932 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S131232AbRCMXGa>;
	Tue, 13 Mar 2001 18:06:30 -0500
Date: Tue, 13 Mar 2001 19:52:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: npsimons@fsmlabs.com,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <200103132105.f2DL5D8411265@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.21.0103131951590.2056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2001, Albert D. Cahalan wrote:

> Bloat removal: being able to run without /proc mounted.
> 
> We don't have "kernel speed". We have kernel-mode screwing around
> with text formatting.

Sounds like you might want to maintain an external patch
for the embedded folks...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

