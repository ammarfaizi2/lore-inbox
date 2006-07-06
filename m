Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965167AbWGFFj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWGFFj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 01:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWGFFj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 01:39:27 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:53732 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S965167AbWGFFj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 01:39:26 -0400
In-Reply-To: <1152162394.24632.58.camel@localhost.localdomain>
References: <1152162394.24632.58.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CCA3F98E-8F8F-4003-87BA-8091F8AB668F@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Xserve G5 thermal control fixes
Date: Thu, 6 Jul 2006 07:37:58 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch also changes the fixed value of the slots fan for
> desktop G5s to 40% instead of 50%. It seems to still have a pretty  
> good
> airflow that way and is much less noisy.

Is this save when people have one of the ridiculously expensive
(and hot) video cards installed?  And perhaps even a few other
cards, too?


Segher

