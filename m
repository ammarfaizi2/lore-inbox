Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136361AbRD2UmX>; Sun, 29 Apr 2001 16:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136354AbRD2UmO>; Sun, 29 Apr 2001 16:42:14 -0400
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:19116 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S136361AbRD2UmA>; Sun, 29 Apr 2001 16:42:00 -0400
Date: Sun, 29 Apr 2001 22:40:53 +0200
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion for module .init.{text,data} sections
Message-ID: <20010429224053.A7269@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Pavel Machek <pavel@suse.cz>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	"Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
	linux-kernel@vger.kernel.org
In-Reply-To: <200104270449.VAA05279@adam.yggdrasil.com> <20010427103519.E679@nightmaster.csn.tu-chemnitz.de> <20010429010522.A32@(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010429010522.A32@(none)>; from pavel@suse.cz on Sun, Apr 29, 2001 at 01:05:23AM +0000
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 01:05:23AM +0000, Pavel Machek wrote:
> 
> You can't do that. Think about interrupt routine being swapped out.
> 
> Kernel is *not* preemptible.

Quite a statement. Would you care to elaborate? I thought there are Unix
(or Unix-like) kernels out there that allow pageing and premption of kernel
parts. Or am i mistaken?

Dominik
-- 
          A lovely thing to see:                   Kobayashi Issa
     through the paper window's holes               (1763-1828)
                the galaxy.               [taken from: David Brin - Sundiver]
