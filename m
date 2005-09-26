Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbVIZMJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbVIZMJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbVIZMJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:09:14 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:33850 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751427AbVIZMJN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=RxY33M26C6SupBimncK1tuqX5q4mTzyYdt49s9yNlZNyRMLOWlC9EOsKPgs2bEoTJHTYJGVBPx2+QVWR1B885q/JI2N7AK8vch3ReCjjLuGT8Sbby2wkFN040hhsvv3vr/+7LHpgG3thC7w3qVP5aRZ+7SHoJFuVU9l8XL2iiR4=
Date: Mon, 26 Sep 2005 14:09:00 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: akpm@osdl.org, alexn@telia.com, torvalds@osdl.org, pavel@suse.cz,
       ebiederm@xmission.com, len.brown@intel.com, drzeus-list@drzeus.cx,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       masouds@masoud.ir, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] suspend: Cleanup calling of power off methods.
Message-Id: <20050926140900.d070b604.diegocg@gmail.com>
In-Reply-To: <695600000.1127332498@flay>
References: <m1vf0vfa0o.fsf@ebiederm.dsl.xmission.com>
	<20050921101855.GD25297@atrey.karlin.mff.cuni.cz>
	<Pine.LNX.4.58.0509210930410.2553@g5.osdl.org>
	<20050921173630.GA2477@localhost.localdomain>
	<20050921203505.32cc714d.diegocg@gmail.com>
	<20050921114948.5b423109.akpm@osdl.org>
	<695600000.1127332498@flay>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 21 Sep 2005 12:54:58 -0700,
"Martin J. Bligh" <mbligh@mbligh.org> escribió:

> http://lists.osdl.org/mailman/listinfo/bugme-new
> 
> But it's not "all changes/new bugs/random crap", it's "new bugs".
> And it's all categories, but there's handy-dandy X- header fields
> to filter on.

I discovered this other ml: http://lists.osdl.org/mailman/listinfo/bugme-janitors 

So, http://lists.osdl.org/mailman/listinfo/bugme-new is just for new bugs
and http://lists.osdl.org/mailman/listinfo/bugme-janitors for everything else,
or bugme-janitors is non-functional? (I tried to subscribe to check it myself but
subscription requires "moderator approval")

If so, can we have the bugme-janitors and bugme-new archives opened for
everyone (so google can index it?)
