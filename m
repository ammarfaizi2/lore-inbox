Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWAVUvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWAVUvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWAVUvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:51:43 -0500
Received: from uproxy.gmail.com ([66.249.92.205]:59238 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750823AbWAVUvm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:51:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IpZcu4cGd1YXmdgBZtfj1Y1OijFxf3NzMNgNPszDn9NXTj5ooG73teazrYE5Y7NHzzthh0Mw1wcKnnD8qqXa0pCodsp9i/N5uKI2Fex7jHLOGwXknYA36/bohk69ZiWzRNq6JVVcfzhvUXom8KLS01dAyisXoznqRsA8cb1L3Hw=
Date: Sun, 22 Jan 2006 21:50:32 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: tytso@mit.edu, nigelenki@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-Id: <20060122215032.c9e4197e.diegocg@gmail.com>
In-Reply-To: <43D3ED8A.3070606@FreeBSD.org>
References: <43D3295E.8040702@comcast.net>
	<20060122093144.GA7127@thunk.org>
	<20060122205039.e8842bae.diegocg@gmail.com>
	<43D3ED8A.3070606@FreeBSD.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sun, 22 Jan 2006 12:39:38 -0800,
Suleiman Souhlal <ssouhlal@FreeBSD.org> escribió:

> Diego Calleja wrote:
> > And FreeBSD is implementing journaling for UFS and getting rid of 
> > softupdates [1]. While this not proves that softupdates is "a bad idea",
> > i think this proves why the added sofupdates complexity doesn't seem
> > to pay off in the real world. 
> 
> You read the message wrong: We're not getting rid of softupdates.
> -- Suleiman


Oh, both systems will be available at the same time? That will be
certainyl a good place to compare both approachs.
