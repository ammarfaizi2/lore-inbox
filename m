Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136952AbRA1NCH>; Sun, 28 Jan 2001 08:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137055AbRA1NB5>; Sun, 28 Jan 2001 08:01:57 -0500
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:58497 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S136952AbRA1NBp>; Sun, 28 Jan 2001 08:01:45 -0500
Date: Sun, 28 Jan 2001 13:57:53 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Gregory Maxwell <greg@linuxpower.cx>
Cc: Dominik Kubla <dominik.kubla@uni-mainz.de>,
        James Sutherland <jas88@cam.ac.uk>,
        David Schwartz <davids@webmaster.com>,
        Jamie Lokier <lk@tantalophile.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: hotmail not dealing with ECN
Message-ID: <20010128135753.A2766@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Gregory Maxwell <greg@linuxpower.cx>,
	James Sutherland <jas88@cam.ac.uk>,
	David Schwartz <davids@webmaster.com>,
	Jamie Lokier <lk@tantalophile.demon.co.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com> <Pine.SOL.4.21.0101272308030.701-100000@green.csi.cam.ac.uk> <20010127191159.B7467@xi.linuxpower.cx> <20010128021025.D800@uni-mainz.de> <20010127233543.D7467@xi.linuxpower.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010127233543.D7467@xi.linuxpower.cx>; from greg@linuxpower.cx on Sat, Jan 27, 2001 at 11:35:43PM -0500
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 27, 2001 at 11:35:43PM -0500, Gregory Maxwell wrote:
...
> An attack against an Xray system is much more likely to come from inside the
> companies network.
...

We are not talking about attacks here, we are talking about undefined
behaviour when (perhaps poorly designed) systems encounter network
packages that use new or experimental features: I have seen MRI scanners
panic when they received SNMP queries and SNMP has been around for ages!

Yours,
  Dominik Kubla
-- 
          A lovely thing to see:                   Kobayashi Issa
     through the paper window's holes               (1763-1828)
                the galaxy.               [taken from: David Brin - Sundiver]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
