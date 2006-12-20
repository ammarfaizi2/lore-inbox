Return-Path: <linux-kernel-owner+w=401wt.eu-S1752903AbWLTAUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbWLTAUx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLTAUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:20:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35937 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbWLTAUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:20:52 -0500
To: davids@webmaster.com
Cc: "Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: GPL only modules
References: <MDEHLPKNGKAHNMBLJOLKKEEOAHAC.davids@webmaster.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Tue, 19 Dec 2006 22:20:42 -0200
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKKEEOAHAC.davids@webmaster.com> (David Schwartz's message of "Mon\, 18 Dec 2006 17\:35\:23 -0800")
Message-ID: <orejqv2zad.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 18, 2006, "David Schwartz" <davids@webmaster.com> wrote:

> It makes no difference whether the "mere aggregation" paragraph kicks in
> because the "mere aggregation" paragraph is *explaining* the *law*. What
> matters is what the law actually *says*.

You mean "mere aggregation" is defined in copyright law?  I don't
think so, otherwise the term 'aggregate' probably wouldn't have
been used in GPLv3.

AFAIK it's perfectly legitimate (even if immoral) for a copyright
license to prohibit the distribution of the software governed by the
license with anything else the author establishes.  E.g., some Java
virtual machine's license used to establish that you couldn't ship it
along with other implementations of Java that didn't pass some
comformance test.

Now, the GPL doesn't do this.  It doesn't say you can't distribute
GPLed software along with any other software.  It only says that, when
you distribute together works that don't constitute mere aggregation
(providing its own definition of mere aggregation), then the whole
must be licensed under the GPL.

> The GPL could say that if you ever see the source code to a GPL'd work,
> every work you ever write must be placed under the GPL. But that wouldn't
> make it true, because that would be a requirement outside the GPL's scope.

It is indeed possible that this would fall outside the scope of
copyright law in the US, and it would not be morally acceptable for
the GPL to impose such a condition.  But then, since nobody can be
forced to see the source code of a GPLed work, or any work for that
matter, acceptance is voluntary, and one shouldn't enter an agreement
one's not willing to abide by.

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
