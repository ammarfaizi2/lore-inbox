Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbTIKQPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTIKQPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:15:10 -0400
Received: from main.gmane.org ([80.91.224.249]:8610 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261327AbTIKQPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:15:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Memory mapped IO vs Port IO
Date: Thu, 11 Sep 2003 18:14:31 +0200
Message-ID: <yw1xbrtr8fq0.fsf@users.sourceforge.net>
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:zOnAginp6MxhLTQJtSfCK5WQmdw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> other things to configure right.  My favourite solution to this problem
> wuld be to ask the question once only and have it apply to all devices:

What if need different settings for different drivers?  I'd go for a
standard question applied to all drivers that have the option.

-- 
Måns Rullgård
mru@users.sf.net

