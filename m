Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129767AbRBRVoy>; Sun, 18 Feb 2001 16:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129850AbRBRVoo>; Sun, 18 Feb 2001 16:44:44 -0500
Received: from net-1-11.campuscommonsapts.com ([216.64.132.11]:42769 "EHLO
	ghettobox.dhs.org") by vger.kernel.org with ESMTP
	id <S129767AbRBRVoc>; Sun, 18 Feb 2001 16:44:32 -0500
Date: Sun, 18 Feb 2001 13:46:02 -0800 (PST)
From: TeknoDragon <andross@ghettobox.dhs.org>
To: Scott Long <smlong@teleport.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux OS boilerplate
In-Reply-To: <3A902F77.8BF6AB52@teleport.com>
Message-ID: <Pine.LNX.4.32.0102181343270.28825-100000@ghettobox.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2001, Scott Long wrote:

> Does there exist an outline (detailed or not) of the boot process from
> the point of BIOS bootsector load to when the kernel proper begins
> execution? If not would anyone be willing to help me understand
> bootsect.S and setup.S enough so that I might write such an outline?

It might be a little fundamental but there is *a* boot loading process
documented here: http://www.eecs.wsu.edu/~cs460/

Look over all the lecture notes and lab assignments up to the booter lab.

I'd offer up my own explanation, but I'm just starting to learn this
stuff.


-karl

