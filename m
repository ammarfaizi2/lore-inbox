Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289481AbSBJKIJ>; Sun, 10 Feb 2002 05:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289487AbSBJKH7>; Sun, 10 Feb 2002 05:07:59 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:39693 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S289481AbSBJKHs>; Sun, 10 Feb 2002 05:07:48 -0500
Date: Sun, 10 Feb 2002 11:07:45 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sonypi in 2.4.18-pre9
Message-ID: <20020210100745.GA18294@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020209115453Z288878-13996+19685@vger.kernel.org> <E16ZcwO-0000ee-00@smtp.fr.alcove.com> <20020209200609.GC32401@come.alcove-fr> <E16Zg6y-0001Dq-00@smtp.fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Zg6y-0001Dq-00@smtp.fr.alcove.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 11:30:06PM +0100, Felix Seeger wrote:

> With kernel 2.4.17, spicctrl -p shows an error message:
> ioctl failed: Invalid argument

That's normal. Power status was added only in 2.4.18-pre1.
In your original mail hovewer, you seemed to state that spicctrl -b/-B
failed on those kernels.

> With kernel 2.4.18-pre9 it works fine, the only difference between the config 
> is that I have enabled IO Device Support.
> I don't know what this is and maybe I don' need it.
> I've only activated it because of the error message (ioctl failed)

My question marks were because I don't know either what IO Device Support
means nor where you did select that. Unless you mean Sony I/O Control
Device Support...

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
