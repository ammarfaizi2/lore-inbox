Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTESMtZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbTESMtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:49:25 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:497 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262451AbTESMtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:49:23 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030519124539.B8868@infradead.org>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
	 <1053292339.10127.45.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
	 <1053341023.9152.64.camel@workshop.saharact.lan>
	 <20030519124539.B8868@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053348984.9142.98.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 19 May 2003 14:56:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 13:45, Christoph Hellwig wrote:
> On Mon, May 19, 2003 at 12:43:44PM +0200, Martin Schlemmer wrote:
> > Ok, lets say we stop doing that.  How do anything user side find
> > out specifics at compile time related to the kernel it should run
> > on ?
> 
> They don't.  You can run the same userspace on a wide range of kernels.
> I'd just leave the job of selcting your headers to the distro vendor -
> if they are too stupid to get their headers sanitized I'd
> just use a different distro.
> 

Ok, so say they use LFS ?

Point is just that people like you keep on bitching about not
using sanitized kernel headers, but do nothing about it, or
until today have said nothing about 'sanitized headers'.


-- 
Martin Schlemmer


