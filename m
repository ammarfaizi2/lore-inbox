Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143370AbREKThA>; Fri, 11 May 2001 15:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143365AbREKTgu>; Fri, 11 May 2001 15:36:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3085 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143370AbREKTge>; Fri, 11 May 2001 15:36:34 -0400
Subject: Re: Latest on Athlon Via KT133A chipset solution?
To: linux-kernel@borntraeger.net (=?iso-8859-1?Q?Christian_Borntr=E4ger?=)
Date: Fri, 11 May 2001 20:14:22 +0100 (BST)
Cc: kernel@llamas.org, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org
In-Reply-To: <007d01c0da4e$6f37b540$d539e195@boeblingen.de.ibm.com> from "=?iso-8859-1?Q?Christian_Borntr=E4ger?=" at May 11, 2001 09:12:30 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yIMo-0001YT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a possibility to get debugging messages or register dumps without a
> second PC? Or is there a possibility to an unbuffered log write? e.g. write

Not much.  You can avoid running syslogk. The one unbuffered log source
is the screen in text mode if not running it via syslogk


