Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLSODy>; Tue, 19 Dec 2000 09:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLSODp>; Tue, 19 Dec 2000 09:03:45 -0500
Received: from staff0130.dada.it ([195.110.97.130]:20608 "EHLO dadafly.dada.it")
	by vger.kernel.org with ESMTP id <S129319AbQLSODd>;
	Tue, 19 Dec 2000 09:03:33 -0500
Date: Tue, 19 Dec 2000 14:27:50 +0100 (CET)
From: Patrizio Bruno <patrizio@dada.it>
To: linux-kernel@vger.kernel.org
Subject: Re: system freeze on 2.4.0-test10 or greater
In-Reply-To: <Pine.LNX.4.10.10012151525150.1094-100000@dadafly.dada.it>
Message-ID: <Pine.LNX.4.10.10012191427060.3776-100000@dadafly.dada.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found that removing modules 'r128' and 'agpgart' my machine doesn't freeze.

P.

---------------------------------------------------------
Patrizio Bruno
DADA spa / Ed-IT Development Staff
Borgo degli Albizi 37/r
50122 Firenze
Italy
tel +39 05520351
fax +39 0552478143

PGP PublicKey available at: http://www.keyserver.net/en/
---------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
