Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261995AbVCMBpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261995AbVCMBpY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 20:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbVCMBpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 20:45:24 -0500
Received: from 83-216-143-24.alista342.adsl.metronet.co.uk ([83.216.143.24]:13582
	"EHLO devzero.co.uk") by vger.kernel.org with ESMTP id S261995AbVCMBpS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 20:45:18 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Any way to get larger fonts in XCONFIG ?
Date: Sun, 13 Mar 2005 01:40:26 +0000
User-Agent: KMail/1.8
Cc: Reg Clemens <reg@dwf.com>, linux-kernel@vger.kernel.org
References: <200503121912.j2CJCcZN025923@orion.dwf.com> <4233638F.90308@osdl.org>
In-Reply-To: <4233638F.90308@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503130140.26472.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 March 2005 21:47, Randy.Dunlap wrote:
> Reg Clemens wrote:
> > Any way to get larger fonts with xconfig?
> > On my system they are just about microscopic.
> >
> > I can do a <ctl><alt?<+> to go to a different screen resolution,
> >  but then I have all sorts of scanning to deal with.
> >
> > Ive looked for documentation, but didnt find it in any of the
> > places I looked...
>
> No automated way to do it AFAIK, but you can edit
> ~/.qt/qtrc and change this line (at least it works for me):
>
> #font=Sans Serif,10,-1,5,50,0,0,0,0,0
> font=Sans Serif,14,-1,5,50,0,0,0,0,0
>
> Changes from 10 point to 14 point font.

That or run "qtconfig", where you can change all the font properties in a GUI.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
