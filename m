Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317679AbSGJXh7>; Wed, 10 Jul 2002 19:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317680AbSGJXh6>; Wed, 10 Jul 2002 19:37:58 -0400
Received: from gremlin.ics.uci.edu ([128.195.1.70]:63394 "HELO
	gremlin.ics.uci.edu") by vger.kernel.org with SMTP
	id <S317679AbSGJXh5>; Wed, 10 Jul 2002 19:37:57 -0400
Date: Wed, 10 Jul 2002 16:40:27 -0700 (PDT)
From: Mukesh Rajan <mrajan@ics.uci.edu>
To: kobras@tat.physik.uni-tuebingen.de
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: HDD test bench
In-Reply-To: <20020710231335.GG29001@khan.acc.umu.se>
Message-ID: <Pine.SOL.4.20.0207101636590.10900-100000@hobbit.ics.uci.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i am currently exploring some power optimization algorithm for HDs
exploiting multiple power states.

i am looking for suggestions to generate a test bench simulating user
activity. i will have to open and read/write to files on the basis of a
trace file. currently i'm doing it in a very ad hoc fashion. i have some
100 dummy files of varying sizes and generating random read/write
requests. any better way would be appreciated. 

thanks,
mukesh

