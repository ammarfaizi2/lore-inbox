Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266478AbSLWDYx>; Sun, 22 Dec 2002 22:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSLWDYx>; Sun, 22 Dec 2002 22:24:53 -0500
Received: from 24.213.60.109.up.mi.chartermi.net ([24.213.60.109]:46315 "EHLO
	front3.chartermi.net") by vger.kernel.org with ESMTP
	id <S266478AbSLWDYw>; Sun, 22 Dec 2002 22:24:52 -0500
Date: Sun, 22 Dec 2002 22:33:15 -0500 (EST)
From: Nathaniel Russell <reddog83@chartermi.net>
X-X-Sender: reddog83@reddog.example.net
To: henrik@hswn.dk
cc: linux-kernel@vger.kernel.org, <alan@redhat.com>,
       <jgarzik@mandrakesoft.com>
Subject: Re: 2.4.20-ac2: sound problems when using realplayer
Message-ID: <Pine.LNX.4.44.0212222223560.1401-100000@reddog.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should check out the thread called
"Via 8233 flooding of errors [2.4-ac]"
Author's are Nathaniel Russell and Alan Cox
It explains in detail about what Alan is trying to figure out, becuase i
had the same problem with an  assertion and he provides a patch which is
experimental like his current Via Audio Driver. What the patch does is
takes the assertion and says if the audio stops then we have a problem
which needs to be sent to Alan and the list. Also Alan would be the person
to ask of any other questions concering the AC driver and Jeff Garzik for
the non AC version of the driver.

