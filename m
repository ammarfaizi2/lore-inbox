Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274242AbRISWw7>; Wed, 19 Sep 2001 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274243AbRISWwv>; Wed, 19 Sep 2001 18:52:51 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:4994 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S274242AbRISWwn>; Wed, 19 Sep 2001 18:52:43 -0400
To: "Rob Fuller" <rfuller@nsisoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
Keywords: phonetics, pseudomorph, hydrothermal
From: "Bryan O'Sullivan" <bos@serpentine.com>
Date: 19 Sep 2001 15:51:45 -0700
In-Reply-To: <878A2048A35CD141AD5FC92C6B776E4907B7A5@xchgind02.nsisw.com>
Message-ID: <878zfaiyke.fsf@pelerin.serpentine.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r> I believe reverse mappings are an essential feature for memory
r> mapped files in order for Linux to support sophisticated
r> distributed file systems or distributed shared memory.

You already have the needed mechanisms for memory-mapped files in the
distributed FS case.  Distributed shared memory is much less
convincing, as DSM types have their heads irretrievably stuck up their
ar^Hcademia.

        <b
