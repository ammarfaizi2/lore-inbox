Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVJaURD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVJaURD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVJaURC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:17:02 -0500
Received: from guru.webcon.ca ([216.194.67.26]:51692 "EHLO guru.webcon.ca")
	by vger.kernel.org with ESMTP id S964821AbVJaUQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:16:57 -0500
Date: Mon, 31 Oct 2005 15:16:56 -0500 (EST)
From: "Ian E. Morgan" <imorgan@webcon.ca>
X-X-Sender: imorgan@light.int.webcon.net
To: linux-kernel@vger.kernel.org
Subject: TI FlashMedia driver
Message-ID: <Pine.LNX.4.64.0510311510130.8105@light.int.webcon.net>
Organization: Webcon, Inc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Assp-Spam-Prob: 0.00000
X-Assp-Envelope-From: imorgan@webcon.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the number of people annoyed by the lack of a driver for TI's
FlashMedia controller (part of the 6xx1 & 7xx1 series chips), myself one of
them, I've started a project to reverse-engineer the device.

Basic details available here, adding new info whenever I get/discover it:
http://www.webcon.ca/~imorgan/tifm21/

Anyone with one of these devices (common in newer notebooks, especially
HP/Compaq units) interested in helping, please check out the above web page
and get on board!

P.S. There are a few reports that a company has already written a Linux
driver for this device, but it was only made available to Texas Instruments.
Although TI's documents do mention Linux support for these devices, there is
absolutely no sign of a driver available anywhere. Queries to TI by myself
any several other people in the past have gone unanswered.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan at webcon dot ca       PGP: #2DA40D07       www.webcon.ca
    *  Customized Linux Network Solutions for your Business  *
-------------------------------------------------------------------
