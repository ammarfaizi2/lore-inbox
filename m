Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316991AbSFWHuK>; Sun, 23 Jun 2002 03:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316992AbSFWHuJ>; Sun, 23 Jun 2002 03:50:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:41234 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316991AbSFWHuI>;
	Sun, 23 Jun 2002 03:50:08 -0400
Date: Sun, 23 Jun 2002 09:54:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: sean darcy <seandarcy@hotmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: piggy broken in 2.5.24 build
Message-ID: <20020623095429.A5667@mars.ravnborg.org>
References: <linux.kernel.20020622213422.A13652@mars.ravnborg.org> <3D1522D8.6030401@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D1522D8.6030401@hotmail.com>; from seandarcy@hotmail.com on Sat, Jun 22, 2002 at 09:22:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 22, 2002 at 09:22:32PM -0400, sean darcy wrote:
> 
> I'm using bash. It's a pretty standard rh7.3 installation.
> 
> .config is attached.
With your .config everything is still fine. Seems you have a problem
on your machine. In another mail you said you had a rather large
disk. Try to do a "df -h" to see how much space is actually available
for the /tmp partition.

> What the hell is piggy???
A simple temporary name.

	Sam 
