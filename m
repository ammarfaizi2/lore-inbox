Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHIOkT>; Fri, 9 Aug 2002 10:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSHIOkT>; Fri, 9 Aug 2002 10:40:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:46066 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313305AbSHIOkS>;
	Fri, 9 Aug 2002 10:40:18 -0400
Subject: Re: Announce: daily 2.5 BK snapshots
From: Paul Larson <plars@austin.ibm.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D52D1C9.9070404@mandrakesoft.com>
References: <Pine.LNX.4.44L.0208081703260.2589-100000@duckman.distro.conectiva> 
	<3D52D1C9.9070404@mandrakesoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 09:36:17 -0500
Message-Id: <1028903778.19435.348.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I probably won't be using this since my scripts already do a nightly
pull, but I'd also like to see what people think of this.  I have a
setup that does a nightly pull of 2.5, builds it for UP and SMP, pushes
to two machines (UP and SMP) and runs LTP on it.  Then sends me back the
results of all of it.  Of course if something fails that didn't fail the
previous day, I have a limited set of Changesets as culprits so it's
easier for me to find the cause of problems when I do more frequent
testing like this.  Any major problems are reported immediatly of
course, but would anyone be interested in seeing the results of this
more often?  I don't know if I have enough space on the LTP website to
post all the data that's gathered every single day (It would add up
REALLY fast), but would a weekly rollup to lkml be something people
would like to see?

Thanks,
Paul Larson

