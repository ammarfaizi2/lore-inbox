Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSEKVlA>; Sat, 11 May 2002 17:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315183AbSEKVk7>; Sat, 11 May 2002 17:40:59 -0400
Received: from khazad-dum.debian.net ([200.196.10.6]:21376 "EHLO
	khazad-dum.debian.net") by vger.kernel.org with ESMTP
	id <S315179AbSEKVk7>; Sat, 11 May 2002 17:40:59 -0400
Date: Sat, 11 May 2002 18:40:50 -0300
To: linux-kernel@vger.kernel.org
Subject: Re: patchset updates 2.4 ide
Message-ID: <20020511184049.A5143@khazad-dum>
In-Reply-To: <Pine.LNX.4.10.10205101157290.3133-100000@master.linux-ide.org> <3CDC5C0B.2070008@rackable.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@rcm.org.br (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, Samuel Flory wrote:
>    Now I need to figure why I'm getting spammed with "invalidate: busy 
> buffer".  It's not this patch as it happens on 2.4.18, and 2.4.19pre7 
> without dma turned on.

I get that all the time from lvm. Here lvm volumes are running on top of
linux software RAID devices; The messages show up when lvm is activated or
deactivated (during system startup and shutdown).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
