Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156663AbPLTFHT>; Mon, 20 Dec 1999 00:07:19 -0500
Received: by vger.rutgers.edu id <S156609AbPLTFHH>; Mon, 20 Dec 1999 00:07:07 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:2166 "EHLO ganymede.isdn.uiuc.edu") by vger.rutgers.edu with ESMTP id <S156642AbPLTFE1>; Mon, 20 Dec 1999 00:04:27 -0500
Date: Sun, 19 Dec 1999 23:04:14 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: linux-kernel@vger.rutgers.edu
Subject: [patch] read[bwl] to isa* for drivers/sound
Message-ID: <19991219230414.A3215@ganymede.isdn.uiuc.edu>
References: <Pine.LNX.4.10.9912152019370.28843-100000@ps.cus.umist.ac.uk> <Pine.LNX.4.10.9912170151570.17829-100000@ps.cus.umist.ac.uk> <19991218032725.A27345@ganymede.isdn.uiuc.edu> <d3iu1wmvcx.fsf@lxplus005.cern.ch> <19991218040234.A27603@ganymede.isdn.uiuc.edu> <19991218190322.A30285@ganymede.isdn.uiuc.edu> <19991218222632.A31121@ganymede.isdn.uiuc.edu> <19991219030642.A31933@ganymede.isdn.uiuc.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
X-Mailer: Mutt 1.0i
In-Reply-To: <19991219030642.A31933@ganymede.isdn.uiuc.edu>; from wendling@ganymede.isdn.uiuc.edu on Sun, Dec 19, 1999 at 03:06:42AM -0600
Sender: owner-linux-kernel@vger.rutgers.edu


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii

Here's some more unsexy patches for the drivers. This time the
drivers/sound subdirectory should be finished. Does this look okay to
everyone? Does anyone care anymore :)?

	Bill

--ikeVEW9yuYc//A+q
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="patch.sound.gz"
Content-Transfer-Encoding: base64

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
zIf1f9m5TJyANQAA

--ikeVEW9yuYc//A+q--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
