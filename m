Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270809AbUJUXGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270809AbUJUXGF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271032AbUJUXFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:05:09 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:39783 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271067AbUJUW6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:58:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Jt+zaLUfOLYNEGFvRZxbKwy09Uk4cRVetDoY7LCrJgSArIoZujQmZOxxZN0iW9Lkbn32sMcTk/9EB2H2pcsB/Tb0kBYCcdJHRhlvkfiguYiiTAvr9ZkMDA0phYaNuTJiZyrmI156b5UOdA1nejiw757Nags4AayuKcXTM+jbXRA=
Message-ID: <58cb370e04102115572e992d75@mail.gmail.com>
Date: Fri, 22 Oct 2004 00:57:56 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <41783CDF.80007@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41780393.3000606@rtr.ca>
	 <58cb370e041021121317083a3a@mail.gmail.com>
	 <1098394354.17096.174.camel@localhost.localdomain>
	 <41783CDF.80007@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2004 18:49:03 -0400, Mark Lord <lkml@rtr.ca> wrote:

> I'll pull down your (Alan) latest tree and re-post a 2.6 patch against it.
> But I would really like to see Marcelo pick up the 2.4 version as well,
> since that is what people are using today.

Therefore 2.4 version is OK with me.
