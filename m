Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261454AbSIWVe3>; Mon, 23 Sep 2002 17:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261455AbSIWVe3>; Mon, 23 Sep 2002 17:34:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55227 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261454AbSIWVe1>;
	Mon, 23 Sep 2002 17:34:27 -0400
Date: Mon, 23 Sep 2002 14:28:34 -0700 (PDT)
Message-Id: <20020923.142834.93051637.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: dmo@osdl.org, axboe@suse.de, phillips@arcor.de, _deepfire@mail.ru,
       linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15759.34928.552606.829570@napali.hpl.hp.com>
References: <15759.34428.608321.969391@napali.hpl.hp.com>
	<20020923.141752.91362457.davem@redhat.com>
	<15759.34928.552606.829570@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Mon, 23 Sep 2002 14:32:32 -0700
   
   Ah, OK, if it's documented that way (with the option of implementing
   it as a single 64-bit store).

This is the idea, yes
