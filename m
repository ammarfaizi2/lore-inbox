Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbREXRNp>; Thu, 24 May 2001 13:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbREXRNZ>; Thu, 24 May 2001 13:13:25 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:3858 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261454AbREXRNI>;
	Thu, 24 May 2001 13:13:08 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105241712.f4OHCRp386469@saturn.cs.uml.edu>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device
To: oxymoron@waste.org (Oliver Xymoron)
Date: Thu, 24 May 2001 13:12:27 -0400 (EDT)
Cc: marko@l-t.ee (Marko Kreen), froese@gmx.de (Edgar Toernig),
        phillips@bonn-fries.net (Daniel Phillips),
        linux-kernel@vger.kernel.org (linux-kernel),
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105240937490.16271-100000@waste.org> from "Oliver Xymoron" at May 24, 2001 09:39:35 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron writes:

> The /dev dir should not be special. At least not to the kernel. I have
> device files in places other than /dev, and you probably do too (hint:
> anonymous FTP).

This is a horribly broken FTP server.
