Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289190AbSA1Omq>; Mon, 28 Jan 2002 09:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSA1Omg>; Mon, 28 Jan 2002 09:42:36 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:14856 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S289191AbSA1OmX>; Mon, 28 Jan 2002 09:42:23 -0500
Date: Mon, 28 Jan 2002 15:42:12 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Dimitrie Paun <dimi@intelliware.ca>
Cc: "'Stelian Pop'" <stelian.pop@fr.alcove.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.18-pre7] sonypi driver update
Message-ID: <20020128144212.GF30456@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <F7EB06D3ED62D311A15600104B6D909F442073@IWD_MAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F7EB06D3ED62D311A15600104B6D909F442073@IWD_MAIL>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2002 at 09:16:19AM -0500, Dimitrie Paun wrote:

> > This new version of the driver is also capable to turn on/off
> > this laptop's bluetooth subsystem (using new ioctls, you will
> > need the updated user mode tools - spicctrl - from 
> > http://www.alcove-labs.org/en/software/sonypi/).
> 
> Why do we keep proliferating ioctls, instead of nice ctrl files?

Do you really want to start the ioctl vs /proc vs something_better_yet
recurrent flamewar ? :-)

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
