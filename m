Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265317AbRFVCzA>; Thu, 21 Jun 2001 22:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbRFVCyv>; Thu, 21 Jun 2001 22:54:51 -0400
Received: from smarty.smart.net ([207.176.80.102]:63755 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S265318AbRFVCyk>;
	Thu, 21 Jun 2001 22:54:40 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200106220305.XAA15554@smarty.smart.net>
Subject: Re: Controversy over dynamic linking -- how to end the panic
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Jun 2001 23:05:13 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
>I agree entirely that Linus, as creator of the license, is
>privileged with respect to interpretation of the license.  I

Richard Stallman is the creator of the license. It's his greatest work.
Linus is in no way priviledged as to interpretation of it, other than
tolerance on the part of the parties that own the copyright to the
license.

The GPL is about "the program". As far as I'm concerned, modules are the
kernel, "the program".  The way to stem any panic that may exist, if you
want to allow binary-only modules (which sucks*, but whatever), is to LGPL
or "KGPL" the kernel. What is being allowed now is in violation of the
GPL. 


Rick Hohensee
www.clienux.com


*How 'bout a nice binary-only Forth running the kernel? Metacompiling
kernel routines into the Forth dictionary and such. Sound creepy? Good.

