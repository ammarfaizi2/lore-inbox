Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270805AbTHAO7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275229AbTHAO7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:59:30 -0400
Received: from main.gmane.org ([80.91.224.249]:28107 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270805AbTHAO73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:59:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Disk speed differences under 2.6.0
Date: Fri, 01 Aug 2003 16:55:35 +0200
Message-ID: <yw1x1xw5jul4.fsf@users.sourceforge.net>
References: <0E3FA95632D6D047BA649F95DAB60E570185F3CF@EXA-ATLANTA.se.lsil.com> <IBEJLCACHGEIBMFJACBEEEJICKAA.glarsen@alpha.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:OJLAKOnfzSBcCqGkz6TRUbToieg=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gordon Larsen" <glarsen@alpha.homedns.org> writes:

> My apologies if this has already been discussed - but has anyone noticed
> disk I/O speed differences under 2.6.0 as compared to 2.4.20?  My system has

It has been discussed.  The solution is "hdparm -a 512 /dev/...".

-- 
Måns Rullgård
mru@users.sf.net

