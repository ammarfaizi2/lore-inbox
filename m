Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264191AbRFLE5z>; Tue, 12 Jun 2001 00:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264176AbRFLE5o>; Tue, 12 Jun 2001 00:57:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39949 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264169AbRFLE5m>; Tue, 12 Jun 2001 00:57:42 -0400
Date: Tue, 12 Jun 2001 00:22:11 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [CFT][PATCH] superblock handling changes
In-Reply-To: <Pine.GSO.4.21.0106112359050.27704-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0106120003080.6617-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Jun 2001, Alexander Viro wrote:

> 	Folks, the patch below the fixed and combined variant of
> the last series of patches sent to Linus.

Al, 

Since you are working on that code, would you mind to add some comments
about IO completion guarantees (also why we don't guarantee fsync() to
work as it should :)) there ?

Thanks






