Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSFTHNe>; Thu, 20 Jun 2002 03:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318137AbSFTHNd>; Thu, 20 Jun 2002 03:13:33 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:49633 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S318136AbSFTHNc>;
	Thu, 20 Jun 2002 03:13:32 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15633.32924.291406.335371@napali.hpl.hp.com>
Date: Thu, 20 Jun 2002 00:13:32 -0700
To: Manik Raina <manik@cisco.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [Trivial Patch] : (2.5 latest) More __builtin_expect() cleanup in favour 
 of likely/unlikely
In-Reply-To: <3D117C53.2B4F7C53@cisco.com>
References: <3D117C53.2B4F7C53@cisco.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 19 Jun 2002 23:55:15 -0700, Manik Raina <manik@cisco.com> said:

  Manik> Copying Rusty as well.

In the future, please cc linux-ia64@linuxia64.org for ia64-specific patches.

  Manik> Changed files in the include/asm-ia64 directory to get rid of
  Manik> __builtin_expect() in favour of likely/unlikely.

The patch looks fine to me.

Thanks,

	--david
