Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310885AbSCHOpE>; Fri, 8 Mar 2002 09:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310884AbSCHOow>; Fri, 8 Mar 2002 09:44:52 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:45961 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S310881AbSCHOoo>; Fri, 8 Mar 2002 09:44:44 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: 160gb maxtor with promise ultra 100
Date: Fri, 08 Mar 2002 15:44:43 +0100
Organization: Internet Factory AG
Message-ID: <3C88CE5B.5B0DFD51@internet-factory.de>
In-Reply-To: <3C87C6CB.F05C3B96@internet-factory.de> <Pine.LNX.4.44.0203071839270.16402-100000@sol.compendium-tech.com>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1015598683 31163 195.122.142.158 (8 Mar 2002 14:44:43 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 8 Mar 2002 14:44:43 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19-pre2-ac3 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kelsey Hudson proclaimed:

> Check promise's website for a bios update for the controller. the earlier
> versions of the ultra100 don't have 48 bit lba support, if i recall
> correctly.

Neither does the latest I know of (2.01 Build 27). This shouldn't be the
problem, though, since the machine boots from SCSI. The Maxtor drives
are just cheap data storage. I also think that the linux driver does not
use the BIOS at all, just the hardware.

Well, let's hope for 2.4.19. Will use the onboard IDE for the time
being.

Holger
