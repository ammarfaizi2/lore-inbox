Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271795AbRILWg5>; Wed, 12 Sep 2001 18:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271820AbRILWgr>; Wed, 12 Sep 2001 18:36:47 -0400
Received: from mx6.port.ru ([194.67.57.16]:11524 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S271795AbRILWgk>;
	Wed, 12 Sep 2001 18:36:40 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109130259.f8D2xKZ00746@vegae.deep.net>
Subject: 2.4.9-ac10 - plague still lives
To: alan@lxorguk.ukuu.org.uk
Date: Thu, 13 Sep 2001 02:59:19 +0000 (UTC)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Alan i finally (hmm already a week or so ago) catched the process 
  which forces to oops all kernels since 2.4.7 - it is kupdated, and 
  it is signed as author of all oopses from the first one appearing to the last.
  It is very likely that i was wrong earlier claiming oopses were related to 
  sound issues - since i never then seen oops with not kupdated being the cause.
        More: ac10 causes mc and vi to segfault badly
  after some time from bootup. While vi segfaults while being tried to run,
  mc segfaults while trying to open some file and edit it (ie you open
  a file, then press anykey and then - you know).
        I suspect here that the fact i havent recompiled glibc and mc 
  to reflect possible kernel interface changes is being the cause.
       Actually 2.4.7 was last stable for me, and i still use it even
 regarding the fact it suffers console-losing issues which recent acs
 dont suffer from.

cheers, Sam
 
