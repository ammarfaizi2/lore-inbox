Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268076AbTCCAXY>; Sun, 2 Mar 2003 19:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268086AbTCCAXY>; Sun, 2 Mar 2003 19:23:24 -0500
Received: from dsl2-09018-wi.customer.centurytel.net ([209.206.215.38]:20099
	"HELO thomasons.org") by vger.kernel.org with SMTP
	id <S268076AbTCCAXY>; Sun, 2 Mar 2003 19:23:24 -0500
From: scott thomason <scott@thomasons.org>
Reply-To: scott@thomasons.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SCSI emulation causes kernel panic
Date: Sun, 2 Mar 2003 18:33:49 -0600
User-Agent: KMail/1.5
References: <200303021601.24433.scott-kernel@thomasons.org>
In-Reply-To: <200303021601.24433.scott-kernel@thomasons.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303021833.49446.scott@thomasons.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 March 2003 04:01 pm, scott thomason wrote:
> Greetings. I haven't been able to find a single version yet in
> the 2.5.x series that allows me to use SCSI emulation without
> a kernel panic...until I tried a strange trick today. Even
> under 2.5.63, I still received the panic documented below,
> until I turned on all the options under "Kernel Hacking". Then
> SCSI emulation seems to work fine!

Note to self: even though the panic disappears, and the device 
appears in /dev, when the device is actually _written_ to using 
cdrecord, various scsi errors happen. Blurf.
---scott

