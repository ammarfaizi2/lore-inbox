Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTADUCS>; Sat, 4 Jan 2003 15:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTADUCS>; Sat, 4 Jan 2003 15:02:18 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:129
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261368AbTADUCR>; Sat, 4 Jan 2003 15:02:17 -0500
Subject: Re: please help me understand a line code about pci
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: fretre lewis <fretre3618@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200301041214.h04CE90f000847@darkstar.example.net>
References: <200301041214.h04CE90f000847@darkstar.example.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041713674.2036.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 04 Jan 2003 20:54:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-04 at 12:14, John Bradford wrote:
> Incidently, wouldn't it be worth printing some debugging info, such as
> the values read from 0xCF8 and 0xCFA, when neither configuration type
> works?  I've attached an, (untested), patch to do so.

That just indicates a system using a non standard conf type - thats
perfectly reasonable.


