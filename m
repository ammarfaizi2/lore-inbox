Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136131AbRD0R1L>; Fri, 27 Apr 2001 13:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136132AbRD0R1C>; Fri, 27 Apr 2001 13:27:02 -0400
Received: from penguin.roanoke.edu ([199.111.154.8]:10253 "EHLO
	penguin.roanoke.edu") by vger.kernel.org with ESMTP
	id <S136131AbRD0R0y>; Fri, 27 Apr 2001 13:26:54 -0400
Message-ID: <3AE9AEB6.AFE25389@linuxjedi.org>
Date: Fri, 27 Apr 2001 13:39:02 -0400
From: "David L. Parsley" <parsley@linuxjedi.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ?
In-Reply-To: <3AE99CE8.BD325F52@antefacto.com>  <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> <15296.988386995@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

> Why copy it into RAM? Why not use cramfs and either turn the writable
> directories into symlinks into a ramfs which you create at boot time, or
> union-mount a ramfs over the top of it?
  ^^^^^^^^^^^

I didn't think we had union-mounting support... does it exist and
I've somehow missed it?

regards,
	David

-- 
David L. Parsley
Network Administrator
Roanoke College
