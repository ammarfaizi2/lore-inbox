Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTL2QFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 11:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTL2QFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 11:05:13 -0500
Received: from imf20aec.mail.bellsouth.net ([205.152.59.68]:62083 "EHLO
	imf20aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S263584AbTL2QFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 11:05:10 -0500
Subject: Re: 2.4.23 can run with HZ==0!
From: Rob Love <rml@ximian.com>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031229155433.GA4475@janus>
References: <20031228230522.GA1876@janus>
	 <1072691126.5223.5.camel@laptop.fenrus.com> <20031229125240.GA4055@janus>
	 <1072711585.4294.8.camel@fur>  <20031229155433.GA4475@janus>
Content-Type: text/plain
Message-Id: <1072713908.4294.10.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Mon, 29 Dec 2003 11:05:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-29 at 10:54, Frank van Maarseveen wrote:

> I missed a two or three cases. Hoever, no sign of the tenfold size increase
> or any fixes inside SCSI ioctls or firewall rules (netfilter code I presume).
> 
> Arjan, are you sure?

I am probably missing places, too.  There are quite a bit.

	Rob Love


