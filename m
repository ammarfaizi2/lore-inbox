Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSEURi1>; Tue, 21 May 2002 13:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315266AbSEURi0>; Tue, 21 May 2002 13:38:26 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:47749 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S315259AbSEURi0>;
	Tue, 21 May 2002 13:38:26 -0400
Date: Tue, 21 May 2002 13:38:27 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Lazy Newbie Question
In-Reply-To: <Pine.LNX.3.95.1020521124137.1506A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.33L2.0205211337490.16426-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well the COMEDI I know about, written mostly by David Schleef, does
> not require manipulating files in kernel space. This is a collection
> of drivers, tools, and libraries for data acquisition.

int kcomedilib_main.c: comedi_t * comedi_open(const char *pathname).

'nuff said.

-Calin

