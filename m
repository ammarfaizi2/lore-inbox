Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTJERvR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTJERvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:51:17 -0400
Received: from main.gmane.org ([80.91.224.249]:20941 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263259AbTJERvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:51:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Freeing unused kernel memnory - bug
Date: Sun, 05 Oct 2003 19:51:11 +0200
Message-ID: <yw1xu16nfu9c.fsf@users.sourceforge.net>
References: <000c01c38b62$50a125e0$f8e4a7c8@bsb.virtua.com.br> <yw1x3ce7ha3w.fsf@users.sourceforge.net>
 <002301c38b66$b10f4980$f8e4a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:mv1xg8quf/pt3T7BfYvjT48z/ok=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> writes:

> > > I'm using 2.4.22 and when i reboot my system , the boot process
> > > stop when "freeing unused memory" message appear.
> >
> > Does it just stop, or does it print some kind of panic message and
> > then stop?
> 
> Just stop

That's odd.  Has the system been working with other kernels?  Are you
using an initrd and forgot to update it for the new kernel?

-- 
Måns Rullgård
mru@users.sf.net

