Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313908AbSDQUfG>; Wed, 17 Apr 2002 16:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313911AbSDQUfF>; Wed, 17 Apr 2002 16:35:05 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:23331 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S313908AbSDQUfE>; Wed, 17 Apr 2002 16:35:04 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A78177F04@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Robert Love'" <rml@tech9.net>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: James Bourne <jbourne@MtRoyal.AB.CA>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: RE: Hyperthreading
Date: Wed, 17 Apr 2002 15:34:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2002-04-17 at 17:10, Martin J. Bligh wrote:
> > > Total of 4 processors activated (14299.95 BogoMIPS).
> > 
> > Before you get too excited about that, how much performance 
> boost do 
> > you actually get by turning on Hyperthreading? ;-)

I've seen some Intel bench's and they are specing an increase of 0% to 30%
(Though check Anandtech, he did a benchmark on his DB, and got a small
performance Decrease on a test!)

After looking at the Hyperthreading Doc's, It looks like they are trying to
utilize some of the idle time the Execution engine has while waiting for
other ops to happen,  Trace code misses, and such.  Strap on an extra
processor state, and get some extra oomph.  Hey, the P4 can use all the
extra oomph it can get!

B.

 

 
