Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316404AbSFUWTZ>; Fri, 21 Jun 2002 18:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316492AbSFUWTY>; Fri, 21 Jun 2002 18:19:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10761 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316404AbSFUWTY>; Fri, 21 Jun 2002 18:19:24 -0400
Subject: Re: Need IDE Taskfile Access
To: tillman@viewcast.com (Scott Tillman)
Date: Fri, 21 Jun 2002 23:40:40 +0100 (BST)
Cc: dalecki@evision-ventures.com (Martin Dalecki),
       B.Zolnierkiewicz@elka.pw.edu.pl (Bartlomiej Zolnierkiewicz),
       arcolin@arcoide.com (Garet Cammer), linux-kernel@vger.kernel.org
In-Reply-To: <CBELJEJGBEIGHCIMEDHNCEPBCIAA.tillman@viewcast.com> from "Scott Tillman" at Jun 19, 2002 06:43:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17LX56-0001nL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm working with a group of people in an effort to get Linux running on the
> XBox.  The XBox uses a set of security PIO commands to restrict access to
> the IDE drive, requiring a 32 byte password to be delivered before sector
> access is allowed.  As far as I can tell from my investigations and from
> earlier discussions with Andre there is currently no way to issue this
> command.  If I'm wrong in my estimation just let me know how, otherwise I
> simply wish add my voice to the (albeit small) outcry for supporting the
> entire ATA spec.

That would I suspect be something for the kerneli patch.
