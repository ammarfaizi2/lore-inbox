Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287494AbRLaMOK>; Mon, 31 Dec 2001 07:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287492AbRLaMOA>; Mon, 31 Dec 2001 07:14:00 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:23594 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287494AbRLaMNq>; Mon, 31 Dec 2001 07:13:46 -0500
Date: Mon, 31 Dec 2001 13:11:55 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix serial close hang
Message-ID: <20011231121155.GA905@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011230135249.A9625@flint.arm.linux.org.uk> <20011230141731.GA7314@elfie.cavy.de> <20011230144235.B9625@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011230144235.B9625@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.24-current-20011230i (Linux 2.4.17-spc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Dec 30 2001, Russell King wrote:

> Whoops.  This should fix it.

Yes, it does. The patch runs perfectly under 2.4.17.

-- 
# Heinz Diehl, 68259 Mannheim, Germany
