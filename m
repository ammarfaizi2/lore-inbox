Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBPCaW>; Thu, 15 Feb 2001 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129808AbRBPCaN>; Thu, 15 Feb 2001 21:30:13 -0500
Received: from zen.via.ecp.fr ([138.195.130.71]:60430 "HELO zen.via.ecp.fr")
	by vger.kernel.org with SMTP id <S129159AbRBPC37>;
	Thu, 15 Feb 2001 21:29:59 -0500
Date: Fri, 16 Feb 2001 03:29:56 +0100
From: Stéphane Borel <stef@via.ecp.fr>
To: linux-kernel@vger.kernel.org
Subject: ServeRaid 4M with IBM netfinity and kernel 2.4.x
Message-ID: <20010216032956.B11267@via.ecp.fr>
Mail-Followup-To: Stéphane Borel <stef@via.ecp.fr>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a problem here that make the filesystem crash during big files
transfer (>1M). It only happens with kernel 2.4.x ; with 2.2.18, it is
very stable and fast.

I have seen a thread some time ago concerning such problem but is there
a solution against it now ?

I should add that the behaviour of serveraid under 2.4 is somehow
strange : during fsck for instance, it seems to get stuck and won't go
further if we don't strike a key on the keyboard.

-- 
Stef
