Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTJGMws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 08:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTJGMwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 08:52:47 -0400
Received: from main.gmane.org ([80.91.224.249]:6882 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262360AbTJGMwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 08:52:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Can't X be elemenated?
Date: Tue, 07 Oct 2003 14:52:36 +0200
Message-ID: <yw1x1xtpfbvv.fsf@users.sourceforge.net>
References: <Pine.LNX.4.44.0309301209590.19804-100000@shell> <Pine.LNX.4.58.0309301316510.12484@dlang.diginsite.com>
 <20031007040449.GM205@openzaurus.ucw.cz> <3F82780C.8080408@pixelized.ch>
 <20031007121825.GA323@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:hgS3j15q/7wtg/IqPkFd6FnAcVk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Well, I'm pretty glad there's only one glibc, and only one http
> protocol, and only one X protocol. And it would be way better if there
> was just one toolkit commonly used on Linux.

There are a few problems with the common toolkits.  Both Qt and GTK
are huge bloated things that tend to take over the entire application.
You have to do everything centered around the GUI toolkit.  If neither
one fits the model of your application, it is sometimes easier to roll
your own toolkit.  Actually, that was how GTK started its life.

The other toolkits are either non-free, immensely ugly, or both.

-- 
Måns Rullgård
mru@users.sf.net

