Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWGKQrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWGKQrf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWGKQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:47:35 -0400
Received: from mail.freedom.ind.br ([201.35.65.90]:13483 "EHLO
	mail.freedom.ind.br") by vger.kernel.org with ESMTP
	id S1751076AbWGKQre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:47:34 -0400
From: Otavio Salvador <otavio@debian.org>
To: joesmidt@byu.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will there be Intel Wireless 3945ABG support?
Organization: O.S. Systems Ltda.
References: <1152635563.4f13f77cjsmidt@byu.edu>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Tue, 11 Jul 2006 13:47:28 -0300
In-Reply-To: <1152635563.4f13f77cjsmidt@byu.edu> (Joseph Michael Smidt's
	message of "Tue, 11 Jul 2006 10:32:43 -0600")
Message-ID: <8764i4ytpb.fsf@nurf.lab.ossystems.com.br>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph Michael Smidt" <jsmidt@byu.edu> writes:

> Will 2.6.18 or 2.6.19 support Intel Wireless 3945ABG?  Please cc me
> since I am not subscribed.  Thanks.

There's a module available[1] for us but it's not merged in mainline yet.

1. http://ipw3945.sourceforge.net/

You could use it in meanwhile.

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
