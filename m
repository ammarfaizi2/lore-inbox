Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVDDUSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVDDUSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 16:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVDDUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 16:14:58 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:27448 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261374AbVDDUNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 16:13:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IL2XZQi5lIo/eWR/W44IbYtvbJUBsM5HGmG3icNiwzE87fB21slLggmAApeQ9rP5qq7IVw04uMHeD4YaLqN7o/IwiVtybrIceVRovBm+bXtabq48UVqIiCy7flemMJqI8MgbQ7YTSN96xFQuGIM7z7qOKr4a7wUBQjXby1iGYzE=
Message-ID: <5a4c581d050404131370707613@mail.gmail.com>
Date: Mon, 4 Apr 2005 22:13:44 +0200
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kernel.org replaced
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d2s5vf$la8$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <d2s5vf$la8$1@terminus.zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 4, 2005 9:53 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> Hello everyone,
> 
> HP has most graciously donated a pair of DL585 quad Opteron servers
> with 24 GB of RAM and 10 TB of disk using a pair of MSA-30 arrays for
> each server.  The first ones of these servers was officially put in
> service today; the next one will be put in service next week.  Each
> server is in a different ISC colo, connected to the Internet via
> gigabit fiber links.

This is excellent news...

> Consequently, we should now see incredibly much better performance
> from kernel.org.  Huge thanks to HP for the new hardware, and huge
> thanks to ISC for letting us quadruple our rack space requirements
> from 5U to 2x10U.  We'll be saturating those links in no time :)

I don't know - 2.6.12-rc2 has been announced a few hours
 ago on http://www.kernel.org , still the patch isn't there.. it
 will be hard to saturate links that way ;)

--alessandro

 "I want to know if it's you I don't trust
  'cause I damn sure don't trust myself"

    (Bruce Springsteen, "Brilliant Disguise")
