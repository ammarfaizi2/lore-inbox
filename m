Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264568AbTK0QlM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTK0QlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:41:12 -0500
Received: from main.gmane.org ([80.91.224.249]:16799 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264568AbTK0QlL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:41:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6 not cat proof
Date: Thu, 27 Nov 2003 17:41:09 +0100
Message-ID: <yw1xoeuxbw7u.fsf@kth.se>
References: <20031126201052.GA16106@outpost.ds9a.nl> <1069877780.7606.0.camel@laptop-linux>
 <20031127073004.GB6275@vega.digitel2002.hu> <yw1xr7zutcmr.fsf@kth.se>
 <20031127035755.2d960969.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:p9oQpxhJaW6rw3H10JAt9YxKfwU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

>> I had to "rm /bin/cat" nine times ...
>
> You're too cruel.

Yes, it I shouldn't have done that.  A while after, the machine
started feeling sluggish, and I started looking around.  I happened to
ls /dev, and it was filled with mouse0, mouse1, mouse2, ...  They kept
coming back after I removed them, too.

-- 
Måns Rullgård
mru@kth.se

