Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSGKFqn>; Thu, 11 Jul 2002 01:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317676AbSGKFqm>; Thu, 11 Jul 2002 01:46:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5569 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317674AbSGKFql>;
	Thu, 11 Jul 2002 01:46:41 -0400
Date: Thu, 11 Jul 2002 07:45:51 +0200
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
       Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: (RE:  using 2.5.25 with IDE) On sparc64.....
Message-ID: <20020711054551.GD1059@suse.de>
References: <61DB42B180EAB34E9D28346C11535A783A7B86@nocmail101.ma.tmpw.net> <Pine.LNX.4.10.10207101459060.16921-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10207101459060.16921-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10 2002, Andre Hedrick wrote:
> 
> The locking code is broken because the port forward fail to carry all
> issues.

Where is it broken? The 2.4 forward port has the exact same locking as
the 2.4 base. And I do mean identical.

-- 
Jens Axboe

