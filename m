Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbVKQVpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVKQVpc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVKQVpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:45:32 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:500 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751361AbVKQVpb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:45:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Af0FK0Kevv4kjjjTRX+V103RJHfjjjYxTkzJKBH42ndClvmlZ/pLcfqOIoEKKM2iHnDzCqGp8+yJXpOmuPt3Ri3irDY8uLWa0JvPk9BUXXiZFyOYWJPCNiFJhfXXfpKZIMpUPf9iZkKUzR2Q5JKGaB6f+4dFGJBwfyFJFeaWe8Q=
Date: Thu, 17 Nov 2005 22:45:13 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Cc: rlrevell@joe-job.com, chrisw@osdl.org, davej@redhat.com,
       galibert@pobox.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-Id: <20051117224513.d80572d0.diegocg@gmail.com>
In-Reply-To: <20051117211856.GS5856@shell0.pdx.osdl.net>
References: <1132172445.25230.73.camel@localhost>
	<20051116220500.GF12505@elf.ucw.cz>
	<20051117170202.GB10402@dspnet.fr.eu.org>
	<1132257432.4438.8.camel@mindpipe>
	<20051117201204.GA32376@dspnet.fr.eu.org>
	<1132258855.4438.11.camel@mindpipe>
	<20051117203731.GG5772@redhat.com>
	<1132260851.5959.15.camel@mindpipe>
	<20051117210643.GG7991@shell0.pdx.osdl.net>
	<1132262060.5959.21.camel@mindpipe>
	<20051117211856.GS5856@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 17 Nov 2005 13:18:56 -0800,
Chris Wright <chrisw@osdl.org> escribió:

> Yeah, bad bug reports are indeed a pain.  One thing that may help ALSA is
> more frequent merging with mainline.  Then the delta between ALSA cvs
> (and hence ALSA developers) and mainline (users) is smaller.

What about using kernel's bugzilla? Alsa has a (weird) bug tracker but
some people reports bugs in bugzilla.kernel.org aswell (just a suggestion,
it seems weird to have two places to report bugs and I bet that's not good
for users)
