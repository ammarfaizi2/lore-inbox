Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTE2JzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTE2JzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:55:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61348 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262093AbTE2JzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:55:23 -0400
Date: Thu, 29 May 2003 03:07:32 -0700 (PDT)
Message-Id: <20030529.030732.70218972.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] lane and mpoa module cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305281155.h4SBtm9m031163@locutus.cmf.nrl.navy.mil>
References: <200305281155.h4SBtm9m031163@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Wed, 28 May 2003 07:55:48 -0400

   the lec and mpoa module both should be safely referenced from the atm
   module (and each other in the case of mpc handling shortcuts for a 
   lec device).
   
Applied, thanks.
