Return-Path: <linux-kernel-owner+w=401wt.eu-S1422638AbXAERYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbXAERYj (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 12:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbXAERYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 12:24:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.237]:48175 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422638AbXAERYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 12:24:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oiqq5q9bIqb0Y31kHgSYHn9M+Osq6wHx8He7tVrGxCEO9zdog7rzIAObnp94Ez+ot6a7+VhR+l1E18lXoVMMAL8iA+cHTbMZ4hfVxlJF0YADJkbrRtxmW+VgifXeyLH7eDHTsgq82Cxvu1F72zox7T7VVymjaggXhSyCL58Y7Tc=
Message-ID: <7ce7bf330701050924h47546970w36ed189ed147ddb3@mail.gmail.com>
Date: Fri, 5 Jan 2007 15:24:36 -0200
From: MoRpHeUz <morpheuz@gmail.com>
To: "Len Brown" <lenb@kernel.org>
Subject: Re: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Cc: "Andrew Morton" <akpm@osdl.org>, "Stelian Pop" <stelian@popies.net>,
       "Mattia Dongili" <malattia@linux.it>,
       "Ismail Donmez" <ismail@pardus.org.tr>,
       "Andrea Gelmini" <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Cacy Rodney" <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <200701051211.08458.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <20070104154434.7e1a7c83.akpm@osdl.org>
	 <7ce7bf330701041820l5132ddbfsd3dd2b6ea826f3ae@mail.gmail.com>
	 <200701051211.08458.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What workaround are you using?

 This one: http://bugzilla.kernel.org/show_bug.cgi?id=7465

> The frequency scaling issue sounds like a BIOS/Linux incompatibility.
> Please open a bugzilla, if you haven't already, and include the
> output from acpidump.

  I agree that it sound like a BIOS/Linux incompatibility. You can
find my acpidump and DSDT inside the link above. That bug is still
opened.

> The nvidia issue sounds like an interrupt issue, so please reproduce
> it using the open source nvidia driver (not the nvidia binary),
> and include the lspci -vv output, dmesg, and /proc/interrupts.

  Will try that !

Thanks !
