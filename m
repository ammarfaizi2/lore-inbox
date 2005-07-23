Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVGWPhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVGWPhO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVGWPhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 11:37:13 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:44973 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261766AbVGWPgW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 11:36:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PrnVV9A2WEOcfA1eb3rx5AP22oN5TH1iSuzWeLb0f/WxA55gOkSA3uED2/8fM6k1gOhep0tyV49v6a5cjuW9u2lR1iIrAZhO6YWZyonPulEsDmmaI3d/X+fjinWX9sKezcsdPfizCc+yl5pfSxCiGTKFjqn8P6dCMw+WV79z0Zs=
Message-ID: <9a8748490507230836584948c6@mail.gmail.com>
Date: Sat, 23 Jul 2005 17:36:22 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: cengizkirli <cengizkirli@gmail.com>
Subject: Re: Mouse Freezes in Xorg on ASUS P4C800 Deluxe
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <c0140e76050723082730836e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0140e76050723082730836e7b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/05, cengizkirli <cengizkirli@gmail.com> wrote:
> distro: Debian Unstable
> kernels tested with: 2.6.13-rc3, 2.6.13-rc3-git5, 2.6.13-rc3-mm1
> compiler used: Debian gcc-4.0.1-2
> Xorg: Debian xorg-6.8.2-4
> ASUS P4C800 Deluxe BIOS: 1019 (2005-11-08)
> 
> with or wihout ACPI enabled (acpi=off or not) the /dev/input/mice USB
> mouse freezes after not being used for some time and can only be
> awakened by switching to the text-console and back.
> 
What's the last kernel it works OK with?
Why do you suspect this to be a kernel problem and not a X.org problem?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
