Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbUAEUbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 15:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbUAEU3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 15:29:16 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:4621 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S265374AbUAEU3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 15:29:07 -0500
Date: Mon, 5 Jan 2004 21:27:05 +0100
From: DervishD <raul@pleyades.net>
To: Martin Hicks <mort@bork.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird problems with printer using USB
Message-ID: <20040105202705.GD15884@DervishD>
References: <20040105192430.GA15884@DervishD> <20040105194606.GA1112@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040105194606.GA1112@localhost>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Martin :)

 * Martin Hicks <mort@bork.org> dixit:
> > kernel: host/usb-uhci.c: interrupt, status 2, frame# 682
> > kernel: printer.c: usblp0: nonzero read/write bulk status received: -110
> > kernel: printer.c: usblp0: error -84 reading printer status
> > kernel: printer.c: usblp0: removed
> I'm getting this same error when printing anything but the smallest
> print job to an HP DeskJet 3550 USB.  Using latest RH9 errata packages.

    Exactly, I have this problem when printing anything large :((
Under Windows is worse, the printer doesn't work at all thru USB...
At least under Linux I can print, with some problems, but I can.

    Thanks for the support :)
 
    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
