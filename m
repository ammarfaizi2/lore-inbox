Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261793AbTCQS23>; Mon, 17 Mar 2003 13:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbTCQS22>; Mon, 17 Mar 2003 13:28:28 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:65185 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S261793AbTCQS22>; Mon, 17 Mar 2003 13:28:28 -0500
Date: Mon, 17 Mar 2003 19:39:20 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Subject: modutils for 2.5
In-Reply-To: <Pine.LNX.4.51.0303171931220.29964@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv>
References: <Pine.LNX.4.51.0303171931220.29964@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a special modutils package needed for 2.5 kernels?

lsmod on 2.5 says QM_MODULES not supported, and while

# make modules_install
i always get tons of unresolved symbols about all what is in the modules.

I tried modutils 2.4.21 and 2.4.23 with the same result

Regards,
Maciej Soltysiak
