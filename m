Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271719AbTHDMtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 08:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271720AbTHDMtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 08:49:11 -0400
Received: from main.gmane.org ([80.91.224.249]:22436 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271719AbTHDMtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 08:49:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: FS: hardlinks on directories
Date: Mon, 04 Aug 2003 14:45:58 +0200
Message-ID: <yw1xsmohioah.fsf@users.sourceforge.net>
References: <20030804141548.5060b9db.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:01LlKTfoB6qIwdc6cPDhkzNYB8k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> writes:

> although it is very likely I am entering (again :-) an ancient
> discussion I would like to ask why hardlinks on directories are not
> allowed/no supported fs action these days. I can't think of a good
> reason for this, but can think of many good reasons why one would
> like to have such a function, amongst those:

I don't know the exact reasons it isn't allowed, but you can always
use "mount --bind" to get a similar effect.

-- 
Måns Rullgård
mru@users.sf.net

