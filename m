Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbULJSrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbULJSrA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbULJSrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:47:00 -0500
Received: from main.gmane.org ([80.91.229.2]:43144 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261795AbULJSqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:46:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Sil3112 and Seagate ST3160023AS
Date: Fri, 10 Dec 2004 19:46:50 +0100
Message-ID: <yw1xvfba2dph.fsf@ford.inprovide.com>
References: <1102691231.3921.13.camel@moeff> <41B9E224.9030705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:Z6NYS/5qGlry8UFQfoKGo11m6Y0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> Julien Langer wrote:
>> Is there a way to disable this fix, which slows down my drive, since it
>> worked fine for a long time without this fix on older kernel versions?
>> I'm using the deprecated ide driver for the sil controller, not libata.
>
> Unfortunately it's just a matter of time until you hit a problem,

How long a time would that be a matter of?  I've been using two
ST3160827AS drives (firmware 3.00 and 3.03) connected to an SiI3114
controller using the libata driver (kernel 2.6.9) for a few weeks, at
full speed, without noticing anything out of the ordinary.  I can't
say I have any heavy load, but I have done some moving around of huge
files, and the usual compilation jobs.

The drives are both new.  Is there a chance Seagate have fixed the
problems?

-- 
Måns Rullgård
mru@inprovide.com

