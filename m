Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284741AbRLPSFD>; Sun, 16 Dec 2001 13:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284746AbRLPSEy>; Sun, 16 Dec 2001 13:04:54 -0500
Received: from hermes.toad.net ([162.33.130.251]:27521 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S284741AbRLPSEj>;
	Sun, 16 Dec 2001 13:04:39 -0500
Subject: PnP BIOS driver
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 16 Dec 2001 13:04:34 -0500
Message-Id: <1008525878.5515.62.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, no one is complaining about the PnP BIOS driver:
   http://panopticon.csustan.edu/thood/pnpbios.html

Marcelo: Can you please put this into 2.4.18-pre ?

(The pnpbios driver provides an interface to PnP BIOS
device configuration functionality.  The interface is
used by the lspnp and setpnp utilities, which are
distributed as part of the pcmcia-cs package.)

--
Thomas Hood

