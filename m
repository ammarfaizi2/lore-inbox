Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVJQSDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVJQSDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVJQSDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:03:10 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:6313 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932090AbVJQSDI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:03:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dr7i1n7b3cr3BFMqAxCEyjCxxNU2NdpzxF4WUufcT5UcQMuCu71tIc9yHClDe+VoSKQth+FKI+OyTsl0zo4HUkSeymIHAMm9VStTmIfpp6vp3aewjAjt2XfR/H9ptqq7AO3j4PlTLJNH9zwGfl3SeBcACk9Sol2xriKREf2QN5I=
Message-ID: <9a8748490510171103s62bdb84ap3d0ba55b65af32e@mail.gmail.com>
Date: Mon, 17 Oct 2005 20:03:06 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: [PATCH] fix implicit declaration compile warning in qla2xxx
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051017180029.GA9192@plap.qlogic.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510171959.23585.jesper.juhl@gmail.com>
	 <20051017180029.GA9192@plap.qlogic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/05, Andrew Vasquez <andrew.vasquez@qlogic.com> wrote:
> On Mon, 17 Oct 2005, Jesper Juhl wrote:
>
> > Fix warning about implicitly declared function in qla_rscn.c
> >   drivers/scsi/qla2xxx/qla_rscn.c:334: warning: implicit declaration of function `fc_remote_port_unblock'
> >
[snip]
>
> Sent earlier:
>
> http://marc.theaimsgroup.com/?l=linux-scsi&m=112907350209822&w=2
>
Hmm, I guess I did a lousy job of searching the archives :(


> Awaiting inclusion.
>
Great :)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
