Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWAWSPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWAWSPL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWAWSPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:15:11 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:20919 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750900AbWAWSPJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:15:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OkF9ELrKfy7WJn4tK9CObvhqwG+qkyfmqatbUIwFdDDiAH1fD7cAnQB6PZbwhX6crOqAbwPF8Xz7fOBDCNcdW7wKvGPWWUrPN7qK4fCMtnv/Qi/Xhm46j9xXhs0Zl8FbFQU93APdjxQ4wjyFF4zbGIzim85skMAlHMB3DqeXjL4=
Date: Mon, 23 Jan 2006 19:14:39 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Syed Ahemed <kingkhan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for CVE-2004-1334 ???
Message-Id: <20060123191439.cfe5d61c.diegocg@gmail.com>
In-Reply-To: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com>
References: <3d53b7120601230939p6e8906fbtb196ab49b9b028c5@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 23 Jan 2006 23:09:49 +0530,
Syed Ahemed <kingkhan@gmail.com> escribió:

> Hi
> I do know this community is busy with more important things , but i am
> out of ideas/search  on this one.
> How do i get the patch for the CVE-2004-1334 ? I have an opensource

Well, 2.4.32 fixes that bug and many others security. Any reason why you 
aren't using the latest version.

You can find links to the changesets in the original security advisory
from guninski (easy to find in google)
