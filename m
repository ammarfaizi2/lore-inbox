Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267981AbUHEVZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267981AbUHEVZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267949AbUHEVZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:25:37 -0400
Received: from the-village.bc.nu ([81.2.110.252]:3775 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267964AbUHEVX6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:23:58 -0400
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1x7jsdh42d.fsf@kth.se>
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
	 <1091644663.21675.51.camel@ghanima>
	 <Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
	 <1091647612.24215.12.camel@ghanima>
	 <Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
	 <411228FF.485E4D07@users.sourceforge.net>
	 <Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
	 <yw1x7jsdh42d.fsf@kth.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1091737280.8366.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 21:21:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 18:45, Måns Rullgård wrote:
> Assuming that the AES code is not in itself considered derived from
> the kernel, I see nothing preventing the source file in the kernel
> tree carrying a BSD license.  Obviously, when used with the kernel the
> GPL will apply, but anyone would be free to take the AES code and
> reuse it under the BSD license.  If, on the other hand, the AES source
> in the kernel only carries a GPL license tag, someone looking at it
> will not be aware that the code is (possibly) available with less
> restrictions form another source.

The random driver has an example of that kind of dual licensing made
explicit. Given code gets modified for the kernel maybe it would be
simpler to just give the URL of the original in the comments so everyone
else (who probably wants the original anyway) can grab it there.

