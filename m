Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVC2PUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVC2PUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 10:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVC2PUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 10:20:11 -0500
Received: from [205.205.44.10] ([205.205.44.10]:45841 "EHLO
	sembo111.teknor.com") by vger.kernel.org with ESMTP id S262305AbVC2PUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 10:20:05 -0500
Message-ID: <5009AD9521A8D41198EE00805F85F18F054EA085@sembo111.teknor.com>
From: "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Delay in a tasklet.
Date: Tue, 29 Mar 2005 10:20:03 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm in the process of writing a linux driver and I have a question in
regards to tasklet :

Is it ok to have large delay "udelay(1000);" in the tasklet?

If not, what should I do? 

Please send the answer to me personally (I'm not subscribe to the mailling
list) :

Sebastien Bouchard 
Software designer
Kontron Canada Inc. 
<mailto:sebastien.bouchard@ca.kontron.com> 
<http://www.kontron.com/> 
Corp. Tel.: (450) 430-5400 
Direct Tel.: (450) 437-4661 x2426 


