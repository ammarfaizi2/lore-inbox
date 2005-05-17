Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVEQBoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVEQBoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVEQBoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:44:19 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:53212 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261733AbVEQBoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:44:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TP0eKPCpck7+sGcBXTXcGYf0rjaPTbZ0IdoaSTHXwOPA3xSEhiruKp1arW7EUgOuG4t7qTD4YsRIoJb5fCAXaWhUTGcEtvDHaCx4tqo++MDcoC9Yj0wtojzJxK6RN3OjxQ4rvUvStasQG45v7JWGsY68OgZIVC2X3f7NOOdR4Vo=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Peter Skipworth <pete@peterskipworth.com>
Subject: Re: [PATCH] BTTV support for Adlink RTV24
Date: Tue, 17 May 2005 05:48:18 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <428945C3.2050109@peterskipworth.com>
In-Reply-To: <428945C3.2050109@peterskipworth.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505170548.18971.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 May 2005 05:15, Peter Skipworth wrote:
> This is my first post, so please let me know if I'm going about this the 
> wrong way.

It seems your mailer converted tabs to spaces and wrapped long lines.

> The bttv module currently lacks support for the Adlink RTV24 capture 
> card. The following patch adds support for the Adlink RTV24 video 
> capture card to the bttv module.
> This patch is against sources for 2.6.11.9.

Please, rediff against 2.6.12-rc4. Support for Kodicom was added since 2.6.11
and your patch no longer applies.
