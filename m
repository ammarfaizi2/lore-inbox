Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293591AbSCFOMF>; Wed, 6 Mar 2002 09:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293589AbSCFOLz>; Wed, 6 Mar 2002 09:11:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34832 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293583AbSCFOLl>; Wed, 6 Mar 2002 09:11:41 -0500
Subject: Re: bitkeeper / IDE cleanup
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 6 Mar 2002 14:26:42 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <3C86110E.7020703@evision-ventures.com> from "Martin Dalecki" at Mar 06, 2002 01:52:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16icNO-0006zD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> HDIO_DRIVE_TASKFILE, which even by concept doesn't provide a true
> backdoor for "vendor specific" mess, due to the misguided attempts
> for command format parsing found there.

They are not misguided - they are done to enable users to filter SSSCA
disk hooks and other extremely unpleasant things like CPRM
