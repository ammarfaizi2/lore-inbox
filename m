Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272807AbTGaIvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 04:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272873AbTGaIvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 04:51:02 -0400
Received: from main.gmane.org ([80.91.224.249]:41618 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272807AbTGaIvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 04:51:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: AX8817x (USB ethernet) problem in 2.6.0-test1
Date: Thu, 31 Jul 2003 10:39:37 +0200
Message-ID: <yw1xu1933x9y.fsf@users.sourceforge.net>
References: <yw1x1xwkgm6z.fsf@zaphod.guide> <20030730175706.GB2333@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:y85XeANeQIcdYmd9QxlPGzJ504E=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>> My Netgear FA120 USB2 ethernet adaptor isn't working properly with
>> Linux 2.6.0-test1.  First off, I had to modify it slightly (patch
>> below) to make it work at all with USB2.
>
> Applied, thanks.

Has anyone looked into what might be causing the terrible receive
performance I'm seeing?  The module author, Dave Hollis, had some
ideas, but I don't know where he's been lately.  Are you there, Dave?

Are there more values with different meanings for USB2 devices?

-- 
Måns Rullgård
mru@users.sf.net

