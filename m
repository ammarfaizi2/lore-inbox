Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269822AbRHQH4c>; Fri, 17 Aug 2001 03:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHQH4X>; Fri, 17 Aug 2001 03:56:23 -0400
Received: from odyssey.netrox.net ([204.253.4.3]:31736 "EHLO t-rex.netrox.net")
	by vger.kernel.org with ESMTP id <S269817AbRHQH4L>;
	Fri, 17 Aug 2001 03:56:11 -0400
Subject: Re: [PATCH] processes with shared vm
From: Robert Love <rml@tech9.net>
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <997973469.7632.10.camel@pc-16>
In-Reply-To: <997973469.7632.10.camel@pc-16>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 17 Aug 2001 03:56:49 -0400
Message-Id: <998035017.663.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Aug 2001 09:50:06 +0200, Terje Eggestad wrote:
> I figured out that it's difficult to find out from /proc
> which processes that share VM (created with clone(CLONE_VM)). 

good idea, but use diff -u

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

