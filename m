Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUFVRaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUFVRaW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUFVRaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:30:14 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:52996 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265041AbUFVR0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:26:47 -0400
Subject: Re: [PATCH] Staircase scheduler v7.3 for 2.6.7
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Panagiotis Papadakos <papadako@csd.uoc.gr>,
       Pauli Virtanen <pauli.virtanen@hut.fi>
In-Reply-To: <40D8507C.3010208@kolivas.org>
References: <40D8507C.3010208@kolivas.org>
Content-Type: text/plain
Date: Tue, 22 Jun 2004 19:26:34 +0200
Message-Id: <1087925194.2273.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-23 at 01:30 +1000, Con Kolivas wrote:
> This is a complete scheduler policy rewrite designed to be intrinsically 
> interactive yet very simple and scalable. See previous announcements for 
> more details.
> 
> This version addresses a few minor bugs that are somewhat difficult to 
> stumble upon but can cause problems. Thanks to the many people who 
> reported their experiences so far, and especially to Pauli Virtanen for 
> extensive testing of a nasty bug and feedback along the way.
> 
> This version improves the gameplay on some games that seem to depend on 
> yield() for locking in places (eg Unreal Tournament), as well as 
> removing an "exploit".

No problems so far :-)
Nice work!

