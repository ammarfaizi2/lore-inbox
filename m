Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTJXPR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 11:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTJXPR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 11:17:29 -0400
Received: from hell.org.pl ([212.244.218.42]:42247 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262297AbTJXPR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 11:17:28 -0400
Date: Fri, 24 Oct 2003 17:18:42 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Pavel Machek <pavel@ucw.cz>
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Message-ID: <20031024151842.GB26732@hell.org.pl>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	M?ns Rullg?rd <mru@users.sourceforge.net>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20031020141512.GA30157@hell.org.pl> <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl> <20031023082410.GC643@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031023082410.GC643@openzaurus.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Pavel Machek:
> Find out which versions break it, pay special atetion to
> hwsleep.c.

I stated in my original mail that the last working version was 2.6.0-test3.
test4 is broken w.r. to S1, and test5 resumes with ACPI interrupts gone.
I'll try to be more specific, though.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
