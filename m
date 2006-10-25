Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422658AbWJYTE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbWJYTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 15:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422669AbWJYTE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 15:04:28 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:23510 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422658AbWJYTE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 15:04:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Radim =?iso-8859-2?q?Lu=BEa?= <xluzar00@stud.fit.vutbr.cz>
Subject: Re: suspend to disk -> resume -> X with DRI extension on R100 chips hangs
Date: Wed, 25 Oct 2006 21:03:47 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <453F01CF.2040106@eva.fit.vutbr.cz>
In-Reply-To: <453F01CF.2040106@eva.fit.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610252103.47886.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 25 October 2006 08:18, Radim Lu¾a wrote:
> Good morning
> 
> I noticed following problem:
> After resuming from suspend to disk Xorg with DRI switched on hangs. 
> System is not affected by Xorg hang. If I login via SSH I can kill X 
> server and start it again - with same result. X server hangs even after 
> I suspend from text mode with X not running and with unloaded modules 
> radeon and drm and resume then and try to start X server. With DRI 
> switched off in xorg.conf X resumes correctly.

Well, I think you'll need to file a bug repart at http://bugzilla.kernel.org
(please add rjwysocki@sisk.pl to the Cc list).

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
