Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVARPHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVARPHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 10:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVARPHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 10:07:36 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:10982 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S261315AbVARPHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 10:07:30 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-9.tower-45.messagelabs.com!1106060848!9539916!1
X-StarScan-Version: 5.4.5; banners=-,-,-
X-Originating-IP: [66.10.26.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4: "access beyond end of device" after ext2 mount
Date: Tue, 18 Jan 2005 10:07:27 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC42B5@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4: "access beyond end of device" after ext2 mount
thread-index: AcT9bwbTYXadNnGgRKmfhXUgqlvuvAAAFWfw
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Mario Holbe" <Mario.Holbe@TU-Ilmenau.DE>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not trying to spread FUD, I am just explaining I had the same issue and
that was the resolution.

-----Original Message-----
From: Andries Brouwer [mailto:aebr@win.tue.nl] 
Sent: Tuesday, January 18, 2005 10:04 AM
To: Piszcz, Justin Michael
Cc: Mario Holbe; linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount

On Tue, Jan 18, 2005 at 09:24:03AM -0500, Piszcz, Justin Michael wrote:

> Is the problem with the drive on the promise board or the drive on the
> VIA chipset?

Oh, please - no FUD. There is no problem, and we understand in detail
what happens and why it happens. There is no need for any speculation.
There is no relation to disk hardware or indeed any hardware.

> Did you check your HDD manual to see if you have
> the 32GB clip enabled?  If so, you need to disable this.
