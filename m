Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269495AbRGaWJP>; Tue, 31 Jul 2001 18:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269503AbRGaWI5>; Tue, 31 Jul 2001 18:08:57 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:33093 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S269495AbRGaWIr>; Tue, 31 Jul 2001 18:08:47 -0400
Message-ID: <3B672C6B.9AC418B0@pp.htv.fi>
Date: Wed, 01 Aug 2001 01:08:43 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33L.0107301904060.5582-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Rik van Riel wrote:
> 
> If you can chose between sucky performance or a chance
> at silent data corruption ... which would you chose ?

Just a side note to this discussion.

I'd be very happy with full data journalling even with 50% performance
penalty... There are applications that require extreme data integrity all
times no matter what happens.

 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
