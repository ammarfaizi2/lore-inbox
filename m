Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265792AbUADRB3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUADRB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:01:29 -0500
Received: from [130.57.169.10] ([130.57.169.10]:48056 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S265792AbUADRB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:01:27 -0500
Subject: Re: Pentium M config option for 2.6
From: Rob Love <rml@ximian.com>
To: Dave Jones <davej@redhat.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, szepe@pinerecords.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040104165028.GC31585@redhat.com>
References: <200401041227.i04CReNI004912@harpo.it.uu.se>
	 <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com>
	 <1073233988.5225.9.camel@fur>  <20040104165028.GC31585@redhat.com>
Content-Type: text/plain
Message-Id: <1073235682.5225.12.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sun, 04 Jan 2004 12:01:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-01-04 at 11:50, Dave Jones wrote:

> FWIW, I agree with it too on the grounds that its non obvious the optimal
> setting is CONFIG_MPENTIUMIII. This seems cleaner IMO than changing the
> helptext to read...
> 
>  "Pentium II"
>  "Pentium III / Pentium 4M"
>  "Pentium 4"

Oh, very much agreed.  Giving it a separate configure option also opens
the door for easily adding an march=pentiumm whenever the gcc folks get
around to adding that.

> My other mail may have sounded like I objected to the patch per se, I don't.

I did not think that, I thought perhaps that you thought that I objected
:)

	Rob Love

