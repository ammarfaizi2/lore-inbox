Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbTIQT7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTIQT7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:59:54 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:39770 "EHLO
	mwinf0302.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262851AbTIQT7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:59:52 -0400
From: jjluza <jjluza@yahoo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: test5-mm2: Unknown symbol when modprobe atm
Date: Wed, 17 Sep 2003 21:59:55 +0200
User-Agent: KMail/1.5.3
References: <200309160153.59196.jjluza@yahoo.fr> <20030915193228.122b52c2.akpm@osdl.org>
In-Reply-To: <20030915193228.122b52c2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309172159.55721.jjluza@yahoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 16 Septembre 2003 04:32, vous avez écrit :
> jjluza <jjluza@yahoo.fr> wrote:
> > I try to make test5-mm2 work on my gateway
> >  I need to load module atm and pppoatm
> >  these 2 modules return errors when I modprobe them.
> >  dmesg says :
> >  atm: Unknown symbol try_atm_clip_ops
> >  pppoatm: Unknown symbol pppoatm_ioctl_set

maybe I forgot a module because of a missing dependancy ?

