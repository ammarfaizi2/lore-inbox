Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTHTRa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262082AbTHTRa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:30:57 -0400
Received: from main.gmane.org ([80.91.224.249]:63709 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262081AbTHTRaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:30:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: how to turn off, or to clear read cache?
Date: Wed, 20 Aug 2003 19:28:02 +0200
Message-ID: <yw1xhe4cb5nh.fsf@users.sourceforge.net>
References: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk> <3F437646.4050107@gamic.com>
 <yw1x8ypocv63.fsf@users.sourceforge.net>
 <20030820164949.GA5613@lsd.di.uminho.pt>
 <yw1xptj0b72s.fsf@users.sourceforge.net> <20030820171713.GA21822@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:k0zsm013kaitMDAe3noReF8s63k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

>> > Will it clear the cache?
>> 
>> It will probably clear some cache to make room for cache from hda.
>> 
>> perl -e '@f[0..100000000]=0'
>> 
>> will do it faster.
>
> Using fillmem will do it better :)

[39 lines of C code]

If you already have that piece of code, of course.

-- 
Måns Rullgård            You can write faster programs in C, but
mru@users.sf.net         you can write programs faster in Perl. 

