Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132825AbRD1KbF>; Sat, 28 Apr 2001 06:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRD1Kaz>; Sat, 28 Apr 2001 06:30:55 -0400
Received: from t2.redhat.com ([199.183.24.243]:33527 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132825AbRD1Kav>; Sat, 28 Apr 2001 06:30:51 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3AE9AEB6.AFE25389@linuxjedi.org> 
In-Reply-To: <3AE9AEB6.AFE25389@linuxjedi.org>  <3AE99CE8.BD325F52@antefacto.com> <Pine.LNX.3.96.1010426203656.22847A-100000@medusa.sparta.lu.se> <15296.988386995@redhat.com> 
To: "David L. Parsley" <parsley@linuxjedi.org>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: ramdisk/tmpfs/ramfs/memfs ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Apr 2001 11:30:40 +0100
Message-ID: <9071.988453840@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


parsley@linuxjedi.org said:
>  I didn't think we had union-mounting support... does it exist and
> I've somehow missed it? 

I think you need Al Viro's namespace stuff for it to work properly.

--
dwmw2


