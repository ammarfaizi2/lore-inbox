Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVBJUTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVBJUTH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVBJUTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:19:07 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:53605 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261660AbVBJUTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:19:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=e4l9/Ox0VMzo9uSImiyKg0b9IjQh9ktN42veNIoTL0otIPJ+rIJJFntkyVoVsAtjczLapCBIBZ+JOBG0scSzXFlasBmM4qc8moxf0qVOC9Pi17I/m1hB6lQDJyZbYiN+guJLDMj4xJDg4bhjVuZkyWtuq6uTPCr9JtLgA+Hn0rA=
Message-ID: <9e473391050210121756874a84@mail.gmail.com>
Date: Thu, 10 Feb 2005 15:17:47 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Cc: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108066096.4085.69.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1107695583.14847.167.camel@localhost.localdomain>
	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>
	 <1108066096.4085.69.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 20:08:15 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> It also explicitly states that Windows 2000 and XP don't support this,
> which leads me to suspect that vendors no longer expect POSTing to be
> possible after initial system boot.

No, it means that some of my ATI cards don't function as secondary
adapters on 2K and XP.

-- 
Jon Smirl
jonsmirl@gmail.com
