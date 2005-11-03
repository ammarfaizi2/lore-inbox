Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbVKCWRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVKCWRX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbVKCWRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:17:23 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:1073 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751404AbVKCWRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:17:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Yqv6N+VA/mSs2NoEzTGCyq4vNI5WMD6HgMV+jbEdBZ5pThVg2AyPKmnuuNqUSL6Cv4FfVX/eAx6AaBem1ltXjihHeuecA7/RLDsv3JoHNsjQ0rXzj9VOSa8KlHhD5oyXgrBZYpLJFfVihzrLShKt3p2LJDKly4Stfe8nbwKkB1c=
Subject: Re: kernel connector upcall API
From: Badari Pulavarty <pbadari@gmail.com>
To: Steve French <smfrench@austin.rr.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <436A89E7.6050304@austin.rr.com>
References: <436A89E7.6050304@austin.rr.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 14:16:58 -0800
Message-Id: <1131056218.24503.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 16:06 -0600, Steve French wrote:
> Are there any new samples/examples of kernel code (and the corresponding 
> userspace upcall) using the new (2.6.14) Linux "connector" (cn.ko)?
> 
> I didn't see anything in mainline yet


Look at process event connector patch posted by Matt Helsley.


http://marc.theaimsgroup.com/?l=linux-kernel&m=113049062305013&w=2

Thanks,
Badari

