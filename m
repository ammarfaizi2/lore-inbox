Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbTBDLI4>; Tue, 4 Feb 2003 06:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbTBDLIz>; Tue, 4 Feb 2003 06:08:55 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16787
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267255AbTBDLIz>; Tue, 4 Feb 2003 06:08:55 -0500
Subject: Re: Help with promise sx6000 card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cuenta de la lista de linux <user_linux@citma.cu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030203221923.M79151@webmail.citma.cu>
References: <20030203221923.M79151@webmail.citma.cu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044360902.23312.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Feb 2003 12:15:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 22:19, Cuenta de la lista de linux wrote:
> Hi all:
> 
> I have installed Red Hat 8 with 2.4.18-14 ,i2o support as module, but i can
> not find my card anywhere.

You need to load i2o_pci, then i2o_core then i2o_block. 


> I2O Core - (C) Copyright 1999 Red Hat Software
> I2O: Event thread created as pid 17
> I2O Block Storage OSM v0.9
>   (c) Copyright 1999-2001 Red Hat Software.
> i2o_block: registered device at major 80
> i2o_block: Checking for Boot device...
> i2o_block: Checking for I2O Block devices...

i2o_pci is not loaded


