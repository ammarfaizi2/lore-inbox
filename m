Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbUK1Svz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUK1Svz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 13:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUK1Svz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 13:51:55 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:54499 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261561AbUK1Svr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 13:51:47 -0500
To: tom@dbservice.com
CC: viro@parcelfarce.linux.theplanet.co.uk, ecki-news2004-05@lina.inka.de,
       linux-kernel@vger.kernel.org
In-reply-to: <41AA17A8.5040403@dbservice.com> (message from Tomas Carnecky on
	Sun, 28 Nov 2004 19:23:36 +0100)
Subject: Re: Problem with ioctl command TCGETS
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYN7z-0001bZ-00@dorka.pomaz.szeredi.hu> <20041128121800.GZ26051@parcelfarce.linux.theplanet.co.uk> <E1CYODw-0001jf-00@dorka.pomaz.szeredi.hu> <20041128124847.GA26051@parcelfarce.linux.theplanet.co.uk> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu> <20041128130319.GB26051@parcelfarce.linux.theplanet.co.uk> <41A9E0FB.8030001@dbservice.com> <20041128152756.GL26051@parcelfarce.linux.theplanet.co.uk> <41AA17A8.5040403@dbservice.com>
Message-Id: <E1CYU8q-0002AO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 28 Nov 2004 19:51:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Was there ever a thread on lkml about a ioctl replacement? I'd
> really like to read about proposals, so far everyone talks only about
> replacing it... but no one wants to say how _exactly_.

I remember from one in May 2001 with a subject "RFD w/info-PATCH]
device arguments from lookup)" and it's offshoots.  It's not all about
ioctls, but there are proposals for improvements to the ioctl
interface and other interesting stuff.  Link to start of thread in
MARC:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=99025355313916&w=2

Miklos
