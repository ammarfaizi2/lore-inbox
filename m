Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAXPhs>; Wed, 24 Jan 2001 10:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRAXPhi>; Wed, 24 Jan 2001 10:37:38 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:36245 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S129401AbRAXPhU>;
	Wed, 24 Jan 2001 10:37:20 -0500
Date: Wed, 24 Jan 2001 10:37:18 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Matthew Jacob <mjacob@feral.com>
cc: <Matt_Domsch@Dell.com>, <ttsig@tuxyturvy.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: No SCSI Ultra 160 with Adaptec Controller
In-Reply-To: <Pine.BSF.4.21.0101232041310.5712-100000@beppo.feral.com>
Message-ID: <Pine.SGI.4.31L.02.0101241034560.313738-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001, Matthew Jacob wrote:

> Actually, aren't a number of newer drives getting upwards of 30MB/s?

It depends .... tests I've done here, with scsi/160 and FC on seagate
drives, the read/write speeds start at ~35MB/s, and peter off to ~22MB/s.

I admit my methodology was crude, but I was more curious than scientificly
precise.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
