Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTILWW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTILWW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:22:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:45468 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbTILWW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:22:56 -0400
Date: Fri, 12 Sep 2003 15:20:11 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Nicolae Mihalache <mache@abcpages.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6-test4 problems: suspend and touchpad
In-Reply-To: <3F61CF12.9020602@abcpages.com>
Message-ID: <Pine.LNX.4.33.0309121519420.984-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2. suspend/resume. With version 2.6test2+acpi patch both swsusp and 
> "echo 3 >/proc/acpi/sleep" worked, being able to somehow successfully 
> resume. In version 2.6test4 there is no /proc/acpi/sleep and swsusp 
> hangs somwhere during an IDE call (I can hand-copy the trace if needed).

Would you please try the latest -mm patch (2.6.0-test5-mm1, I believe) and 
report your findings? 

Thanks,


	Pat

