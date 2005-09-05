Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVIEU3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVIEU3d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVIEU3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:29:33 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:23616 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932280AbVIEU3c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:29:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hrUnS4lhK9IpzD5r36JjGfMMIrHXYHWtgNbhymsMtzWZNxNwRnr84nB8CE/8oS+PH27xF/SMlZXn0S8JePo7x9blQUIqeSfnQpQCc9heuM9heYM+V4B+vpUa0wFj2SLSbgfTWuuTdHOcMOEmF2NE5TINMYoBX2im8b8nZ2Pai/8=
Message-ID: <9a87484905090513292d611391@mail.gmail.com>
Date: Mon, 5 Sep 2005 22:29:32 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH] Omnikey Cardman 4000 driver
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20050906013545.GB16056@rama.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050906013545.GB16056@rama.de.gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/05, Harald Welte <laforge@gnumonks.org> wrote:
> Hi!
> 
> Following-up to the Cardman 4040 driver, I'm now sumitting a driver for
> the Cardman 4000 reader.  It is, too, a PCMCIA smartcard reader and the
> predecessor of the 4040.
> 
> From a technical point of view, the two devices have nothing in common,
> so there is no possibility of code sharing.
> 
> Please consider mergin mainline, thanks.
> 
> Note: The patch is incremental to the Cardman 4040 driver that has
> already been submitted.
> 
[snip]

Please see my CodingStyle comments for your previous driver as well as
the cleanup patch I just posted for that one. A lot of those issues
apply to your new driver as well - care to clean that up?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
