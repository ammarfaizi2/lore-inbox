Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266296AbSL1TKS>; Sat, 28 Dec 2002 14:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbSL1TKS>; Sat, 28 Dec 2002 14:10:18 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:12 "EHLO aslan.scsiguy.com")
	by vger.kernel.org with ESMTP id <S266297AbSL1TKS>;
	Sat, 28 Dec 2002 14:10:18 -0500
Date: Sat, 28 Dec 2002 12:16:50 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
       Rik van Riel <riel@conectiva.com.br>
cc: Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G 
Message-ID: <712898112.1041103010@aslan.scsiguy.com>
In-Reply-To: <200212281500.gBSF0pc01929@localhost.localdomain>
References: <200212281500.gBSF0pc01929@localhost.localdomain>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So far, the only bug report I have is from Andrew Morton proving that it
> still  doesn't get it's bounce buffers right.

That hasn't applied since 6.2.10 or so.  2.5.X is still using 6.2.4.

--
Justin

