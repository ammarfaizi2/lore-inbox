Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUBBMoo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 07:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265477AbUBBMoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 07:44:44 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:24585 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265467AbUBBMon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 07:44:43 -0500
Date: Mon, 2 Feb 2004 13:45:38 +0100
From: DervishD <raul@pleyades.net>
To: John Bradford <john@grabjohn.com>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with IDE taskfile
Message-ID: <20040202124538.GC624@DervishD>
References: <20040202120120.GC570@DervishD> <200402021217.i12CHJdP001539@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200402021217.i12CHJdP001539@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi John :)

 * John Bradford <john@grabjohn.com> dixit:
> > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: status=3D0x51 { Dri=
> > veReady SeekComplete Error }
> > <28>Feb  2 12:18:41 kernel: hdb: task_no_data_intr: error=3D0x04 { Driv=
> > eStatusError }
> >     The problem is that message from function 'task_no_data_intr'.
> > What can be the problem?
> The drive doesn't understand the command it was sent.

    After looking at the sources I thought the same, but I wasn't
sure and the message is frightening ;))

    Thanks for the explanation, John :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
