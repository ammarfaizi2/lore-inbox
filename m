Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRIGEp5>; Fri, 7 Sep 2001 00:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271109AbRIGEpr>; Fri, 7 Sep 2001 00:45:47 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:19218 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S271108AbRIGEpi>; Fri, 7 Sep 2001 00:45:38 -0400
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other
	patches
From: Robert Love <rml@tech9.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109062135280.1643-100000@devel.office>
In-Reply-To: <Pine.LNX.4.33.0109062135280.1643-100000@devel.office>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 07 Sep 2001 00:45:59 -0400
Message-Id: <999837964.865.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-09-07 at 00:36, Christoph Lameter wrote:
> Given the minimal nature of the patch I would suggest that it become part
> of 2.4.10 or 11

Are you kidding?  We will be lucky to see this in during 2.5.

Its a pretty big change.  It makes the Linux kernel preemptible.   This
is a fairly big move, one I don't think any of the major Unices have
done.  The only reason the patch is not _huge_ is because the Linux
kernel is already setup for concurrency of this nature -- it does SMP.

I suggest you read
http://www.linuxdevices.com/articles/AT4185744181.html
http://www.linuxdevices.com/articles/AT5152980814.html
http://kpreempt.sourceforge.net

and my previous threads on this issue, for more informaiton.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

