Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbREOBLg>; Mon, 14 May 2001 21:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbREOBLZ>; Mon, 14 May 2001 21:11:25 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:3423 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S262598AbREOBLN>; Mon, 14 May 2001 21:11:13 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: LANANA: To Pending Device Number Registrants 
In-Reply-To: Your message of "Mon, 14 May 2001 23:55:37 +0100."
             <E14zRFZ-0001dI-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 May 2001 11:10:49 +1000
Message-ID: <9153.989889049@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2001 23:55:37 +0100 (BST), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> > And lilo ?
>Also hdparm
>raidtools
>psmisc
>mtools
>mt-st
>gpm
>joystick

kmod, /etc/modules.conf:

alias block-major-what-random-number-did-the-kernel-pick-this-time driver_name

