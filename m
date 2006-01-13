Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161498AbWAMIcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161498AbWAMIcO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161497AbWAMIcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:32:05 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:63421 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1161496AbWAMIcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:32:03 -0500
Subject: Re: patch: problem with sco
From: Marcel Holtmann <marcel@holtmann.org>
To: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com
In-Reply-To: <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de>
	 <1137057244.3955.3.camel@localhost.localdomain>
	 <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 09:27:05 +0100
Message-Id: <1137140826.3879.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfgang,

> > send in the information from "hciconfig -a" for this device, because
> > this is a hardware bug and you can't be sure that you can have eight
> > outstanding SCO packets.

does anything changes if you load the hci_usb driver with reset=1 ?

Regards

Marcel


