Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129342AbRBSWUv>; Mon, 19 Feb 2001 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRBSWUl>; Mon, 19 Feb 2001 17:20:41 -0500
Received: from palrel1.hp.com ([156.153.255.242]:22797 "HELO palrel1.hp.com")
	by vger.kernel.org with SMTP id <S129983AbRBSWUe>;
	Mon, 19 Feb 2001 17:20:34 -0500
From: Rick Jones <raj@cup.hp.com>
Message-Id: <200102192220.OAA01017@tardy.cup.hp.com>
Subject: Re: MTU and 2.4.x kernel
To: kuznet@ms2.inr.ac.ru
Date: Mon, 19 Feb 2001 14:20:31 -0800 (PST)
Cc: alan@lxorguk.ukuu.org.uk, roger@kea.GRace.CRi.NZ,
        linux-kernel@vger.kernel.org
In-Reply-To: <200102191826.VAA12894@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb "19," 2001 "09:26:38" pm
X-Mailer: ELM [$Revision: 1.17.214.2 $]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the TCP code should be "honouring" the link-local MTU in its selection
of MSS.

rick jones
