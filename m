Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSFKV1t>; Tue, 11 Jun 2002 17:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSFKV1s>; Tue, 11 Jun 2002 17:27:48 -0400
Received: from tapu.f00f.org ([66.60.186.129]:41695 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S310206AbSFKV1r>;
	Tue, 11 Jun 2002 17:27:47 -0400
Date: Tue, 11 Jun 2002 14:27:27 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Cc: Daniela Engert <dani@ngrt.de>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Serverworks OSB4 in impossible state
Message-ID: <20020611212727.GA3529@tapu.f00f.org>
In-Reply-To: <20020611064201.9F55DEDBE@mail.medav.de> <1023794726.23733.375.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 01:25:25PM +0200, Martin Wilck wrote:

    Is it possible that the 4-byte shift occurs only with some
    particular (older?) version of the chipset?

Maybe.

I have an oldish OSB4 here and beating on it only with the CDROM
(disks are all SCSI) I don't ever seem to see this problem:

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
        Flags: bus master, medium devsel, latency 48

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
        Flags: bus master, medium devsel, latency 48

I think what is really required is input from ServerWorks/Broadcom
about this.



  --cw
