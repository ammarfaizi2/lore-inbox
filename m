Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272767AbRIGVY7>; Fri, 7 Sep 2001 17:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272856AbRIGVYu>; Fri, 7 Sep 2001 17:24:50 -0400
Received: from johnson.mail.mindspring.net ([207.69.200.177]:57352 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S272767AbRIGVYi>; Fri, 7 Sep 2001 17:24:38 -0400
Subject: Re: ext3-2.4-0.9.9
From: Robert Love <rml@ufl.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <3B991346.7393E7AF@zip.com.au>
In-Reply-To: <3B991346.7393E7AF@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 07 Sep 2001 17:24:56 -0400
Message-Id: <999897902.839.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For reference, I am using 2.4.9-ac9 + ext3-0.9.9 + dir_speedup +
kpreempt with no problem.  I have my root mounted as ext3, type ordered,
with a local journal.

I don't have any data points on performance gains, but I would be happy
to provide any if you specify what.  Everything feels good.

I see no reason not to merge this into Alan's tree.  At least
ext3-0.9.9, but the directory speedup seems reasonable enough too.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

