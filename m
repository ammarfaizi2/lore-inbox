Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317636AbSGXWsB>; Wed, 24 Jul 2002 18:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSGXWsB>; Wed, 24 Jul 2002 18:48:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:61606 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317636AbSGXWsA>; Wed, 24 Jul 2002 18:48:00 -0400
Subject: Re: Linux-2.5.28
From: Paul Larson <plars@austin.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1027549369.931.1354.camel@sinai>
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
	<1027547187.7700.67.camel@plars.austin.ibm.com>
	<1027547856.7700.70.camel@plars.austin.ibm.com> 
	<20020724221423.GD25038@holomorphy.com>  <1027549369.931.1354.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 24 Jul 2002 17:49:09 -0500
Message-Id: <1027550949.7700.102.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 17:22, Robert Love wrote:
> He reported the cmd640 driver... but we really do not need 100 "it does
> not compile reports" on lkml.  Just grep your tree for the old global
It was not my intention to provide something unimportant to lkml, but
the same config worked on the same machine in linux-2.5.27 and then was
not working on 2.5.28.  Since it had only recently broken, it's more
likely that whatever broke it will still be fresh on somebody's mind and
I was hoping that would make it easier for someone to fix.

