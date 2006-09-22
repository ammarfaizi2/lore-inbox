Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWIVU2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWIVU2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 16:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWIVU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 16:28:47 -0400
Received: from motgate4.mot.com ([144.189.100.102]:3565 "EHLO motgate4.mot.com")
	by vger.kernel.org with ESMTP id S964888AbWIVU2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 16:28:46 -0400
X-POPI: The contents of this message are Motorola Internal Use Only (MIUO)
       unless indicated otherwise in the message.
Date: Fri, 22 Sep 2006 15:28:23 -0500 (CDT)
Message-Id: <200609222028.k8MKSN5h008476@olwen.urbana.css.mot.com>
From: "Scott E. Preece" <preece@motorola.com>
To: pavel@ucw.cz
CC: eugeny.mints@gmail.com, linux-pm@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-reply-to: Pavel Machek's message of Fri, 22 Sep 2006 16:09:37 +0200
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| From pavel@ucw.cz Fri Sep 22 09:12:25 2006

Hi, Pavel,

| ...
|
| > | Okay, state here means "operating point". How will operating points
| > | look on 8cpu box? That's 256 states if cpus only support "low" and
| > | "high". How do you name them?
| > 
| > I don't think you would name the compounded states. Each CPU would need
| > to have its own defined set of operating points (since the capabilities
| > of the CPUs can reasonably be different).
| 
| Well, having few "powerop domains" per system would likely solve that
| problem... and problem of 20 devices on my PC. Can we get that?
---

I've been hoping somebody would send a good description of exactly what
they mean by "power domain" or "voltage domain", so we could talk about
it... 

scott
-- 
scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  
e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com


