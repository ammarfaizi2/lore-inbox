Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSFBVRE>; Sun, 2 Jun 2002 17:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314340AbSFBVRD>; Sun, 2 Jun 2002 17:17:03 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:17374 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314284AbSFBVRC>; Sun, 2 Jun 2002 17:17:02 -0400
Date: Sun, 2 Jun 2002 15:16:56 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: SMB filesystem
In-Reply-To: <3CFA875D.1050300@linkvest.com>
Message-ID: <Pine.LNX.4.44.0206021515160.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Jun 2002, Jean-Eric Cuendet wrote:
> [blah]
> How do you think is the best way of doing things?
> Making a minimal FS kernel driver that communicate with a complex 
> userspace daemon?

Virtual loop device? Have an userspace daemon feed it into a loop device, 
and make the kernel mount that. Just suggesting...

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

