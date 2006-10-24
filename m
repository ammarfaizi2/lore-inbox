Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWJXIbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWJXIbJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWJXIbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:31:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:9165 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965112AbWJXIbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:31:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Qs/LkdcbRIcixh71wevmjHAwQ7+kDmj4ifH2wOkg5b0wH84cOdYdNzYJv0lenxzd0xmmZYqcPj3r86fz4rkHsBtnRgMAdQY1kXVq7BvKTPVpLO5MprhzhAEp5JsQzHJNRCyN6w4s5w9eLdBm6xrW6O74tsiHtTOuDoYHkb+uOO0=
Message-ID: <84144f020610240131j7603a75ftf8d8a5718e895699@mail.gmail.com>
Date: Tue, 24 Oct 2006 11:31:06 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: Mitch <Mitch@0bits.com>
Subject: Re: [Fwd: Re: More uml build failures on 2.16.19-rc3 and 2.6.18.1]
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <453DCB33.3060607@0Bits.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453DCB33.3060607@0Bits.COM>
X-Google-Sender-Auth: 70631aeb720702ab
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/06, Mitch <Mitch@0bits.com> wrote:
> Yup, did do 'make mrproper'. config attached.

Works for me. Perhaps the UML people can figure out what's going on.

                                     Pekka
