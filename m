Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUBGJj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 04:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266673AbUBGJj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 04:39:58 -0500
Received: from odpn1.odpn.net ([212.40.96.53]:33742 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S266648AbUBGJj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 04:39:57 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       ballen@gravity.phys.uwm.edu
Subject: Re: Linux 2.4.25-pre7 - no DRQ after issuing WRITE
References: <Pine.LNX.4.58L.0401231652020.19820@logos.cnet> <x6ptd8l7so@gzp>
	<Pine.LNX.4.58L.0401251714400.1311@logos.cnet> <x6oesrj029@gzp>
From: "Gabor Z. Papp" <gzp@papp.hu>
Date: Sat, 07 Feb 2004 10:39:52 +0100
Message-ID: <x6y8rf8byv@gzp>
User-Agent: Gnus/5.1004 (Gnus v5.10.4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Authenticated: gzp1 odpn1.odpn.net a3085bdc7b32ae4d7418f70f85f7cf5f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* "Gabor Z. Papp" <gzp@papp.hu>:

| | I'm not IDE expert, but these errors look like hardware fault for me
| | (Bartlomiej CCed).

Replaced the really bad disk with a good one, and the DRQ problem
still exist. What to do?

http://gzp.odpn.net/tmp/linux-2.4.25-pre7-nr3/

