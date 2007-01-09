Return-Path: <linux-kernel-owner+w=401wt.eu-S1751151AbXAIIP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbXAIIP2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 03:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbXAIIP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 03:15:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:53704 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbXAIIP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 03:15:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a9uxDvl1C7O69Po+e/jFYC4NYz9QzadC03qxBisJhGfWwkpLt9zCQE5UlLvaGMOMI+HEhXl2/BBUL2bV3j+zEDdo7V7s2CIMu708XvnhGpBkUTLN+jeNFZWaVAogh+5Pj+w5jXAdbtfgk4+/TZiWl+ES8l2wAs97Yn1CgThH8SM=
Message-ID: <3d57814d0701090015p676d8d2cuf56fc53c0a10b12c@mail.gmail.com>
Date: Tue, 9 Jan 2007 18:15:25 +1000
From: "Trent Waddington" <trent.waddington@gmail.com>
To: "Rok Markovic" <kernel@kanardia.eu>
Subject: Re: Accelerated driver for linux 2.6
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45A34DC5.4030706@kanardia.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45A34517.2030102@kanardia.eu>
	 <3d57814d0701082333i6d9eefcdibd1d6438246de726@mail.gmail.com>
	 <45A348C4.7060304@kanardia.eu>
	 <3d57814d0701082355k3f96c48dh3cf88339d3a9a6e3@mail.gmail.com>
	 <45A34DC5.4030706@kanardia.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/07, Rok Markovic <kernel@kanardia.eu> wrote:
> I want to write open source driver. BUT I don't know if i am allowed to
> do this. Our company is small, just a few researchers, and most of software
> written is published under GPL licence (not all, but that is firmware for uC),
> all of the communication protocols are public and API is well documented,
> because we all agreed that we are selling hardware not software.
>
> Our lawyer will review the licence, and then I can tell you more.

Ok, sounds good.  Pop over to http://nouveau.freedesktop.org/wiki/ and
look at what they are doing.  For the linux kernel, you are interested
in the DRM component.  You should read this link:

    http://people.freedesktop.org/~ajax/dri-explanation.txt

which explains what each component in the linux graphics pipeline does.

Also have a look at this link:

    http://dri.freedesktop.org/wiki/MesaDriver

Hope that helps you.

Trent
