Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbVAEQEC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbVAEQEC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 11:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbVAEQDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 11:03:13 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:27351 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262490AbVAEPzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:55:18 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10 TCP troubles
Date: Wed, 05 Jan 2005 15:30:46 GMT
Message-ID: <0508LRB12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
>
> Mail agent comments:
>   Sender configuration is suspicious.
> 
> On Wed, Jan 05, 2005 at 12:50:57PM +0000, Hubert Tonneau wrote:
> [quote reformatted to fit within 80 columns]
> > The problem seems to me to be related to the way the TCP layer is
> > handling small troubles (probably lost packets on the Mac side because
> > the Linux machine is gigabit connected to the switch, with flow control
> > enabled, and the Mac is 100 Mbps connected, full duplex, but without
> > flow control).
> 
> What OS is the Mac running? If it's Mac OS, then is it Mac OS X or is it
> an earlier version?

The Mac are all running OSX.
 

