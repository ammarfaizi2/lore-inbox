Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVAKA6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVAKA6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVAKA5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:57:45 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:7976 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262608AbVAKApd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:45:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=f2I/9dKIpCRfdJjpwmPB7CbdJQsiqKB98XcAWWvztjbvJ/l09bvUXGielKKjg0/npgTmFygdQ9laUzWDuKcK+VcWyHh4cHPn9jGaBxuVsSHlh3/7I7oMpWUt+PgJdGIt8XC9mSteMC8cSmhUjdMPQNNqT5mcUAI8VnhKC41vV7I=
Date: Tue, 11 Jan 2005 01:45:51 +0100
From: Diego Calleja <diegocg@gmail.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: steve@rueb.com, linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security
 vulnerabilities?
Message-Id: <20050111014551.7d5254b9.diegocg@gmail.com>
In-Reply-To: <20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net>
References: <41E2B181.3060009@rueb.com>
	<87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
	<20050110230827.4d13ae7b.diegocg@gmail.com>
	<20050111001901.GA4378@ip68-4-98-123.oc.oc.cox.net>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 10 Jan 2005 16:19:01 -0800 "Barry K. Nathan" <barryn@pobox.com> escribió:

> On Mon, Jan 10, 2005 at 11:08:27PM +0100, Diego Calleja wrote:
> > They could have mailed to *THIS* mailing list, so anyone can make a patch.
> 
> And abandon the whole idea of coordinated disclosure? That would put
> anyone using vendor kernels at a disadvantage (there would be a time gap
> between the vulnerability being public and the vendor kernel being
> released -- which happened anyway with uselib() but which doesn't
> *always* happen).

Yes it wouldn't be "coordinated disclosure" but at least you'd get a patch
instead of a public exploit. 
