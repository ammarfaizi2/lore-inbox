Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRHULyM>; Tue, 21 Aug 2001 07:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271551AbRHULxw>; Tue, 21 Aug 2001 07:53:52 -0400
Received: from relay02.cablecom.net ([62.2.33.102]:12810 "EHLO
	relay02.cablecom.net") by vger.kernel.org with ESMTP
	id <S269437AbRHULxl>; Tue, 21 Aug 2001 07:53:41 -0400
Message-Id: <200108211153.f7LBrpk08803@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
Date: Tue, 21 Aug 2001 13:53:45 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Subject: SOCK_SEQPACKET
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

when reading the man page for sockets i saw the socket SOCK_SEQPACKET
which meets my requirements quite good. unfortunatly the man page also sais 
that SOCK_SEQPACKET is not implementet by the protocol famaly PF_INET
(misleadingly calld AF_INET in the man page). whats about PF_INET6?

chris
