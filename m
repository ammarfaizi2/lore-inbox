Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTJERXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 13:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263210AbTJERXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 13:23:37 -0400
Received: from main.gmane.org ([80.91.224.249]:5837 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263179AbTJERXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 13:23:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Freeing unused kernel memnory - bug
Date: Sun, 05 Oct 2003 19:23:31 +0200
Message-ID: <yw1x3ce7ha3w.fsf@users.sourceforge.net>
References: <000c01c38b62$50a125e0$f8e4a7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Obu0NmqjZuhjBl/PM/X4fYxqEto=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> writes:

> I´m using 2.4.22 and when i reboot my system , the boot process stop when
> "freeing unused memory" message appear.

Does it just stop, or does it print some kind of panic message and
then stop?

-- 
Måns Rullgård
mru@users.sf.net

