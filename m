Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTHTNbc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 09:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbTHTNbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 09:31:32 -0400
Received: from main.gmane.org ([80.91.224.249]:34268 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261957AbTHTNbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 09:31:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: how to turn off, or to clear read cache?
Date: Wed, 20 Aug 2003 15:31:32 +0200
Message-ID: <yw1x8ypocv63.fsf@users.sourceforge.net>
References: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk> <3F437646.4050107@gamic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:pJ/ogtCcwn+3CnBe/zymhTQeXFE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Spiridonov <spiridonov@gamic.com> writes:

>>> I need to make some performance tests. I need to switch off or to
>>> clear read cache, so that consequent reading of the same file will
>>> take the same amount of time.
>>>
>>>Is there an easy way to do it, without rebuilding the kernel?
>> Unmount and remount the filesystem.
>
>
> Would
>
> # mount -o remount
>
> do the job?

no

-- 
Måns Rullgård
mru@users.sf.net

