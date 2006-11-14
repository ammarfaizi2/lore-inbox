Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933275AbWKNIs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275AbWKNIs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933280AbWKNIs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:48:58 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17888 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S933275AbWKNIs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:48:57 -0500
In-Reply-To: <20061113174621.GA17406@khazad-dum.debian.net>
Subject: Re: How to document dimension units for virtual files?
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Greg KH <greg@kroah.com>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       Pavel Machek <pavel@ucw.cz>, Randy Dunlap <randy.dunlap@oracle.com>,
       Arnd Bergmann <ARNDB@de.ibm.com>
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF6F233616.CC7685E3-ON41257226.00303CBA-41257226.0030872B@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Tue, 14 Nov 2006 09:50:03 +0100
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 14/11/2006 09:52:08
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrique de Moraes Holschuh <hmh@hmh.eng.br> wrote on 11/13/2006 06:46:21
PM:
> and it does look better.  But unless Greg changes his mind, it looks like
we
> shall do without units in the filenames, which will also work just fine,
if
> small enough units are choosen...
>

As Arnd already said, at least for memory sizes this will work perfectly.
There is no
smaller unit than a byte :-)

Michael

