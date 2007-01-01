Return-Path: <linux-kernel-owner+w=401wt.eu-S932898AbXAAEcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932898AbXAAEcZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 23:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbXAAEcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 23:32:25 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:39740 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932898AbXAAEcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 23:32:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p84txeolnjXY7+cHEaxSn33ey5XHUTdv2Dw1JuuyHWKFYcDkfM2nQWSqG01ymbyTd/KcrJEOkV4uTtr7K49i0GKbRIzDthT4psaqgovyG0kCg8akDMs/0XyOWoy2h17oK0fHdwoKPHMVK6GmODlV8KpnsYD86boEEGjd7A5e/UY=
Message-ID: <625fc13d0612312032t79cafcdt5595eff5ca6888b7@mail.gmail.com>
Date: Sun, 31 Dec 2006 22:32:17 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [PATCH] Make JFFS depend on CONFIG_BROKEN
Cc: "Jeff Garzik" <jeff@garzik.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       jffs-dev@axis.com, "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <20061230213749.GE20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <625fc13d0612180525m500fcecdta08edebb3dd526a6@mail.gmail.com>
	 <20061230213749.GE20714@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Dec 18, 2006 at 07:25:56AM -0600, Josh Boyer wrote:
> > +       NOTE: This filesystem is deprecated and is scheduled for removal in
> > +       2.6.21.  See Documentation/feature-removal-schedule.txt
> >...
>
> $ grep -i jffs Documentation/feature-removal-schedule.txt
> $

This was a follow on patch to Jeff's 'kill-jffs' branch.  He asked me
to resend it as a separate patch without all the quoted context.

Jeff?

josh
