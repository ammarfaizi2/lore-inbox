Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267875AbUHEVre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267875AbUHEVre (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267836AbUHEVrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:47:06 -0400
Received: from mail.broadpark.no ([217.13.4.2]:63897 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S268000AbUHEVhe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:37:34 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.8-rc3 - BSD licensing
References: <Xine.LNX.4.44.0408041156310.9291-100000@dhcp83-76.boston.redhat.com>
	<1091644663.21675.51.camel@ghanima>
	<Pine.LNX.4.58.0408041146070.24588@ppc970.osdl.org>
	<1091647612.24215.12.camel@ghanima>
	<Pine.LNX.4.58.0408041251060.24588@ppc970.osdl.org>
	<411228FF.485E4D07@users.sourceforge.net>
	<Pine.LNX.4.58.0408050941590.24588@ppc970.osdl.org>
	<yw1x7jsdh42d.fsf@kth.se>
	<1091737280.8366.1.camel@localhost.localdomain>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Thu, 05 Aug 2004 23:37:09 +0200
In-Reply-To: <1091737280.8366.1.camel@localhost.localdomain> (Alan Cox's
 message of "Thu, 05 Aug 2004 21:21:21 +0100")
Message-ID: <yw1xisbxfere.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Iau, 2004-08-05 at 18:45, Måns Rullgård wrote:
>> Assuming that the AES code is not in itself considered derived from
>> the kernel, I see nothing preventing the source file in the kernel
>> tree carrying a BSD license.  Obviously, when used with the kernel the
>> GPL will apply, but anyone would be free to take the AES code and
>> reuse it under the BSD license.  If, on the other hand, the AES source
>> in the kernel only carries a GPL license tag, someone looking at it
>> will not be aware that the code is (possibly) available with less
>> restrictions form another source.
>
> The random driver has an example of that kind of dual licensing made
> explicit. Given code gets modified for the kernel maybe it would be
> simpler to just give the URL of the original in the comments so everyone
> else (who probably wants the original anyway) can grab it there.

That doesn't make it any nicer to replace one license with another
without the author's permission.  Adding an explicit GPL is fine, the
BSD license allows that.  However, it also requires that the original
license remain in place.

-- 
Måns Rullgård
mru@kth.se
