Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319397AbSIFVFQ>; Fri, 6 Sep 2002 17:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319402AbSIFVFQ>; Fri, 6 Sep 2002 17:05:16 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:13255 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S319397AbSIFVFP>; Fri, 6 Sep 2002 17:05:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: DevilKin <devilkin-lkml@blindguardian.org>
To: <Hell.Surfers@cwctv.net>, linux-kernel@vger.kernel.org
Subject: Re: Re: ide drive dying?
Date: Fri, 6 Sep 2002 23:07:01 +0200
User-Agent: KMail/1.4.1
References: <0d2bf5139200692DTVMAIL9@smtp.cwctv.net>
In-Reply-To: <0d2bf5139200692DTVMAIL9@smtp.cwctv.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209062307.02048.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 September 2002 22:40, Hell.Surfers@cwctv.net wrote:
> Is a drive you cant rely on worth having?

Very good question... 

the DFT has finished it's work, and tells me no more bad sectors are 
present... for how long?

To the swap guru's: what does linux do if it attempts to write to swap, and 
gets an error code returned from the ide layer?

DK
-- 
The streets are safe in Philadelphia, it's only the people who make
them unsafe.
		-- Mayor Frank Rizzo

