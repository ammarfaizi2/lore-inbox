Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263543AbTJVTeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 15:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbTJVTeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 15:34:25 -0400
Received: from hell.org.pl ([212.244.218.42]:6927 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263543AbTJVTeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 15:34:13 -0400
Date: Wed, 22 Oct 2003 21:34:10 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: rob@landley.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] Re: Test8 suspend fails if laptop lid closed.
Message-ID: <20031022193410.GA15176@hell.org.pl>
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	rob@landley.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>
References: <200310220122.27837.rob@landley.net> <1066846447.2406.1.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1066846447.2406.1.camel@laptop-linux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Nigel Cunningham:
> A couple of us have seen the same thing under 2.4. I've found a hack
> solution for my laptop, but need to investigate more. It certainly looks
> like an ACPI problem from here.

Provided he's actually using ACPI. My laptop will halt the processor and
enter a sort of stanby state if when legacy (APM) mode and the lid is 
closed.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
