Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWAOOkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWAOOkd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 09:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWAOOkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 09:40:33 -0500
Received: from dresden.studentenwerk.mhn.de ([141.84.225.229]:42966 "EHLO
	email.studentenwerk.mhn.de") by vger.kernel.org with ESMTP
	id S1750920AbWAOOkc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 09:40:32 -0500
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Organization: Studentenwerk =?iso-8859-1?q?M=FCnchen?=
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Sun, 15 Jan 2006 15:40:27 +0100
User-Agent: KMail/1.7.2
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de> <1137140826.3879.1.camel@localhost.localdomain>
In-Reply-To: <1137140826.3879.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601151540.28879.wolfgang.walter@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

Am Freitag, 13. Januar 2006 09:27 schrieb Marcel Holtmann:
> Hi Wolfgang,
>
> > > send in the information from "hciconfig -a" for this device, because
> > > this is a hardware bug and you can't be sure that you can have eight
> > > outstanding SCO packets.
>
> does anything changes if you load the hci_usb driver with reset=1 ?
>

So, I tested this today: changed nothing. Neither the output of hciconfig has 
changed nor any data is sent to the headset.

Regards,

-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
Leiter EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196 276
Fax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
