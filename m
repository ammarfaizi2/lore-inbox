Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWBWMyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWBWMyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWBWMyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:54:15 -0500
Received: from odin2.bull.net ([192.90.70.84]:56203 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751186AbWBWMyN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:54:13 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: RT : 2.6.15-rt17 and possible softlockup detected on CPU#1!
Date: Thu, 23 Feb 2006 14:01:40 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200602231354.32259.Serge.Noiraud@bull.net> <20060223124715.GA11291@elte.hu>
In-Reply-To: <20060223124715.GA11291@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602231401.40365.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeudi 23 Février 2006 13:47, Ingo Molnar wrote/a écrit :
> 
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> > These messages occurs while my RT program loops.
> 
> what priority does your RT program have?
I tried  with 10, 30, 50 and 99.
> 
> 	Ingo
> 

-- 
Serge Noiraud
