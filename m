Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264389AbRFOMyb>; Fri, 15 Jun 2001 08:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264395AbRFOMyU>; Fri, 15 Jun 2001 08:54:20 -0400
Received: from mail.ftr.nl ([212.115.175.146]:57337 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S264389AbRFOMyD>; Fri, 15 Jun 2001 08:54:03 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F1477@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Mike Black <mblack@csihq.com>, linux-kernel@vger.kernel.org
Subject: RE: Client receives TCP packets but does not ACK
Date: Fri, 15 Jun 2001 14:53:59 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> TCP is NOT a guaranteed protocol -- you can't just blast data from one
port
> to another and expect it to work.

Isn't it? Are you really sure about that? I thought UDP was the
not-guaranteed-one and TCP was the one guaranting that all data reaches the
other end in order and all. Please enlighten me.

