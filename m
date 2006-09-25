Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWIYTAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWIYTAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWIYTAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 15:00:45 -0400
Received: from s1.bay2.hotmail.com ([65.54.246.99]:26038 "EHLO
	bay0-omc1-s27.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751485AbWIYTAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 15:00:45 -0400
Message-ID: <BAY103-F29C1E2AFF782CB840E7EE085240@phx.gbl>
X-Originating-IP: [66.46.92.242]
X-Originating-Email: [ig_sh@hotmail.com]
From: "Igor Sharovar" <ig_sh@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Problem of using a PCI device in a Hot Plug PCI slot
Date: Mon, 25 Sep 2006 15:00:40 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 25 Sep 2006 19:00:44.0371 (UTC) FILETIME=[E73AB230:01C6E0D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

A PCI card, which developed in my company, isn't powered in a Hot Plug PCI 
slot(  Intel server ).
During boot-up, a populated slot powers up, then immediately powers off.
The card works fine in non Hot Plug slots. The Hot Plug PCI specification 
says that a regular PCI card should at least be powered in a Hot Plug PCI 
slot.
What are requirements for running a PCI card in a Hot Plug slot.
I would appreciate any help.

Igor

_________________________________________________________________
Buy what you want when you want it on Sympatico / MSN Shopping 
http://shopping.sympatico.msn.ca/content/shp/?ctId=2,ptnrid=176,ptnrdata=081805

