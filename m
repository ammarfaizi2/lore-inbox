Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTLEBnH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTLEBnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:43:07 -0500
Received: from fep07-0.kolumbus.fi ([193.229.0.51]:60863 "EHLO
	fep07-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263784AbTLEBnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:43:05 -0500
Date: Fri, 5 Dec 2003 01:42:13 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Andy Isaacson <adi@hexapodia.org>
cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
In-Reply-To: <20031204172348.A14054@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0312050130130.2330@ua178d119.elisa.omakaista.fi>
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Dec 2003, Andy Isaacson wrote:

> I'm curious -- does NTFS implement sparse files?  

Since Win2000 (NTFS 3.0+). Also many recently discussed features like
file/directory/volume level compression/encryption, undelete, power of 2
block sizes between 512-64kB, etc.

> Does the Win32 API provide any way to manipulate them?  

More than what Linux provides in general, e.g. "make hole" is also
possible.

	Szaka
