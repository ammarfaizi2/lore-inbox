Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136632AbREAPJ5>; Tue, 1 May 2001 11:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136630AbREAPJr>; Tue, 1 May 2001 11:09:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20745 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136622AbREAPJg>; Tue, 1 May 2001 11:09:36 -0400
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
To: mantel@suse.de (Hubert Mantel)
Date: Tue, 1 May 2001 16:13:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010501163804.D14970@suse.de> from "Hubert Mantel" at May 01, 2001 04:38:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ubqK-0001nU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I assume you are maintaining them as separate patches anyway in order to 
> be able to feed them to Linus.

Nope - the dependancies between them are too complex
