Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268180AbUIPWW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268180AbUIPWW5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPWVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:21:49 -0400
Received: from launch.server101.com ([216.218.196.178]:21416 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S268004AbUIPWTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:19:25 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: cijoml@volny.cz
Subject: Re: CD-ROM can't be ejected
Date: Fri, 17 Sep 2004 08:17:10 +1000
User-Agent: KMail/1.6.1
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200409160025.35961.cijoml@volny.cz> <20040916122400.GB3544@suse.de> <200409162348.51806.cijoml@volny.cz>
In-Reply-To: <200409162348.51806.cijoml@volny.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409170817.10138.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 Sep 2004 07:48, Bc. Michal Semler wrote:
> Dne èt 16. záøí 2004 14:24 Jens Axboe napsal(a):

> > well there you go, that is what is keeping the drive locked. cdrom
> > cannot know which process locked it or not, all it knows is that the
> > usage count is non-zero on umount, so it doesn't unlock the tray.
>
> Well I killed cpudyn and everything behaves the same... :(

Sorry to butt in, but I'm curious to know if this is the mitsumi drive on the 
Acer TravelMate 242X you are referring to?  

Thanks.

tim
