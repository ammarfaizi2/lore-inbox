Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271569AbRIMMvi>; Thu, 13 Sep 2001 08:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271572AbRIMMv1>; Thu, 13 Sep 2001 08:51:27 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58130 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271569AbRIMMvO>; Thu, 13 Sep 2001 08:51:14 -0400
Subject: Re: junk values at ppplogin
To: csaradap@mihy.mot.com (csaradap)
Date: Thu, 13 Sep 2001 13:55:44 +0100 (BST)
Cc: linux-india-help@lists.sourceforge.net (linux-india-help@lists.sourceforge.net),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3BA0A0D0.19E0E76F@mihy.mot.com> from "csaradap" at Sep 13, 2001 05:34:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15hW1w-0006WL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am configuring a ppp link over null modem. When I am trying to login =
> I
> get junk values like
> 
> ~=FF}#=C0!}!}!} }4}"}&} } } } }%}&*}]=DDH}'}"}(}"=C9=C2~~=FF}#=C0!}!}!}=
>  }4}"}&} } } }
> }%}&*}]=DDH}'}"}(}"=C9=C2~~=FF}#=C0!}!}!} }4}"}&} } } }

Those are PPP packets. You probably dont need to "log in" except via ppp
authentication (pap/chap)
