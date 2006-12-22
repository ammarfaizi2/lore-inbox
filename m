Return-Path: <linux-kernel-owner+w=401wt.eu-S1753046AbWLVWOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbWLVWOo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 17:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbWLVWOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 17:14:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:41124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbWLVWOn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 17:14:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PmLWhhh2LDWdO+nwYpdxB5QpnqLMqHSh1lvQ394HnsRFMzSTsKTFKIOiUjTnq114xyPXJIlqS6eBhYZ/rin+dvqEQRogFN9PulM2GFtwNgVvctzidddUOCwNxz5bw6ic7fdjTHy9QZtlpd7swAtN51WQm0y8SJAl7Cy42gfiqT0=
Message-ID: <7b69d1470612221414h7bca6dd3x89f52be55a47746d@mail.gmail.com>
Date: Fri, 22 Dec 2006 16:14:41 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: "Wolfgang Draxinger" <wdraxinger@darkstargames.de>
Subject: Re: Binary Drivers
Cc: LKML <linux-kernel@vger.kernel.org>, "Rok Markovic" <kernel@kanardia.eu>
In-Reply-To: <200612222300.17463.wdraxinger@darkstargames.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <34142027@web.de> <458C308D.6070606@kanardia.eu>
	 <200612222300.17463.wdraxinger@darkstargames.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/06, Wolfgang Draxinger <wdraxinger@darkstargames.de> wrote:
> Am Freitag, 22. Dezember 2006 20:22 schrieb Rok Markovic:
> > Hi!
> >
> > Maybe this does not belong to this thread, but I am wondering why
> > manufactorers doesn't want to release specifications about drivers....
>
> You're not alone, I think everybody who knows, how things in a
> computer work shares this view.
---

Two of the specific arguments I've heard are (a) that the board (and
its hardware interfaces that the documentation would describe) involve
IP licensed from a third party, which the board manufacturer does not
have a legal right to disclose, or (b) that there is, in fact, no
suitable documentation, because the boards are developed somewhat
fluidly and the driver is developed directly from low-level knowledge
that simply isn't written down in a form suitable for passing on.

If you're building products with no expectation of supporting outside
driver developers, both of those are quite possible.

scott
