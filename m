Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287297AbSALSqC>; Sat, 12 Jan 2002 13:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSALSpy>; Sat, 12 Jan 2002 13:45:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54544 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287297AbSALSph>; Sat, 12 Jan 2002 13:45:37 -0500
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
To: wtarreau@yahoo.fr (=?iso-8859-1?q?willy=20tarreau?=)
Date: Sat, 12 Jan 2002 18:57:22 +0000 (GMT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20020112090017.87174.qmail@web20501.mail.yahoo.com> from "=?iso-8859-1?q?willy=20tarreau?=" at Jan 12, 2002 10:00:17 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PTLG-0002sm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, I cannot imagine that they could break
> compatibility by removing CMOV !

It wouldnt be a break. They explicitly allow themselves to do so in their
documentation.
 

