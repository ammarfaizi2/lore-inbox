Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbVJFPSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbVJFPSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVJFPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:18:54 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:7917 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S1751088AbVJFPSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:18:53 -0400
Date: Thu, 6 Oct 2005 10:18:49 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051006151849.GA26573@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it> <E1EMutG-0001Hd-7U@be1.lrz> <87k6gsjalu.fsf@amaterasu.srvr.nix> <3e1162e60510050755l590a696bx655eb0b7ac05aab6@mail.gmail.com> <Pine.LNX.4.58.0510051744480.2279@be1.lrz> <3e1162e60510050941l55485cbdgf6135e314a015d8f@mail.gmail.com> <20051005232330.GS10538@lkcl.net> <20051006115339.6fd736a0.grundig@teleline.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006115339.6fd736a0.grundig@teleline.es>
X-Operating-System: Linux yggdrasil 2.6.13.3 #1 SMP Tue Oct 4 15:13:58 CDT 2005 i686 GNU/Linux
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 11:53:39AM +0200, grundig@teleline.es wrote:
> What's the point of caring about security for a legacy app if nobody 
> is going to fix it if a security problema arises?
> 
> 
> http://packages.debian.org/unstable/admin/libpam-tmpdir 
> 
> is good enought IMO

That reminds me, gdm hangs (on Debian sid, anyway) when using the 
pam_tmpdir.so module.  I was meaning to file a bugreport... guess I'd 
better get moving.
