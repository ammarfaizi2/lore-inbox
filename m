Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751844AbWCEVmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWCEVmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWCEVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:42:40 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:20432 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751844AbWCEVmk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:42:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tuw9CY4O6H7xMRYnttz1GlLnmXBuJ6r10Ipi8vmj6jexYaVVf77k7UUUrLtHWRosfFAlaXUDEMOtTcDyTdUh2KTLrQOdAe6sMG//rCMLV8JAH8c5uZdFOEItnyMEXlo7xS9n0Yw5sCJ0sRq6lk0fbLC2HhsS1aACnSuCTPlbgAE=
Message-ID: <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com>
Date: Sun, 5 Mar 2006 22:42:39 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: jonathan@jonmasters.org
Subject: Re: [OT] inotify hack for locate
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Jon Masters <jonmasters@gmail.com> wrote:
> Folks,
>
> I'm fed up with those finds running whenever I power on.

You run updatedb at boot time?
Why not run it from cron at night like most people do?
Personally I run it at 04:40.



--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
