Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130211AbRBVSxg>; Thu, 22 Feb 2001 13:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRBVSx0>; Thu, 22 Feb 2001 13:53:26 -0500
Received: from mail.cps.matrix.com.br ([200.196.9.5]:14598 "EHLO
	mail.cps.matrix.com.br") by vger.kernel.org with ESMTP
	id <S130211AbRBVSxP>; Thu, 22 Feb 2001 13:53:15 -0500
Date: Thu, 22 Feb 2001 15:52:51 -0300
To: Jes Sorensen <jes@linuxcare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
Message-ID: <20010222155251.A8207@godzillah>
In-Reply-To: <94ae7g9o8t.fsf@religion.informatik.uni-bremen.de> <E14VZCs-00023R-00@the-village.bc.nu> <14996.14604.348038.42765@pizda.ninka.net> <948zmy97zc.fsf@religion.informatik.uni-bremen.de> <d3y9uyj1is.fsf@lxplus015.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <d3y9uyj1is.fsf@lxplus015.cern.ch>; from jes@linuxcare.com on Qui, Fev 22, 2001 at 02:22:19 +0100
X-GPG-Fingerprint-1: 1024D/128D36EE 50AC 661A 7963 0BBA 8155  43D5 6EF7 F36B 128D 36EE
X-GPG-Fingerprint-2: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
From: hmh@rcm.org.br (Henrique de Moraes Holschuh)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Jes Sorensen wrote:
> Alan forwarded a patch to me from DaveM which fixed it for me.

Jes, could you forward it here as well?

> The problems I were seeing were much more than every 2 hrs, more like
> every 10-15 mins. Anyway it seems it got fixed.

I've seen IRC sessions getting dropped every 10-15 minutes as well, and
about 70% outgoing http connections (to a FreeBSD proxy) dropping in less
than 1 second. It was so bad here I had to downgrade to 2.2.18 (which fixed
all the issues, so I'm pretty sure it was kernel trouble and not network
trouble).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
