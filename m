Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289016AbSAFTaa>; Sun, 6 Jan 2002 14:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289014AbSAFTaK>; Sun, 6 Jan 2002 14:30:10 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:44465 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289013AbSAFT3y>;
	Sun, 6 Jan 2002 14:29:54 -0500
From: dewar@gnat.com
To: dewar@gnat.com, gdr@codesourcery.com, mrs@windriver.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020106192953.E518CF30AD@nile.gnat.com>
Date: Sun,  6 Jan 2002 14:29:53 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perhaps the right construct is an attribute on a pointer variable that
says essentially: use the bits, forget the provenance.
