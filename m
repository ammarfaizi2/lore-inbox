Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272591AbTHKNf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272592AbTHKNf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:35:26 -0400
Received: from main.gmane.org ([80.91.224.249]:49309 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S272591AbTHKNfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:35:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Kconfig -- kill "if you want to read about modules, see" crap?
Date: Mon, 11 Aug 2003 15:35:12 +0200
Message-ID: <yw1xekzsqpv3.fsf@users.sourceforge.net>
References: <20030811132127.GA2596@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:XdrD8Hq1yFiWaro2yIdNEUyCIqs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Each and every input driver (and other drivers are not better)
> contains this
>
> 	  This driver is also available as a module ( = code which can be
> 	  inserted in and removed from the running kernel whenever you want).
> 	  The module will be called input. If you want to compile it as a
> 	  module, say M here and read <file:Documentation/modules.txt>.
>
> text. Perhaps having 1000 copies of same help test is bad idea? Maybe
> CONFIG_MODULE can explain users what modules are, and we can have help
> texts that are actually usefull?

I agree, but it would be nice to show the name of the module in the
help text.  These are not always obvious.

-- 
Måns Rullgård
mru@users.sf.net

