Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVBOK2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVBOK2n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 05:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVBOK2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 05:28:43 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:29881 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261669AbVBOK2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 05:28:42 -0500
From: Vincent Roqueta <vincent.roqueta@ext.bull.net>
Organization: BULL SA
To: linux-kernel@vger.kernel.org
Subject: Re: UDP and e1000 : Simple test,  little bugs.
Date: Tue, 15 Feb 2005 11:34:39 +0100
User-Agent: KMail/1.6.1
References: <200502151108.46768.vincent.roqueta@ext.bull.net>
In-Reply-To: <200502151108.46768.vincent.roqueta@ext.bull.net>
MIME-Version: 1.0
Message-Id: <200502151134.39224.vincent.roqueta@ext.bull.net>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/02/2005 11:37:24,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/02/2005 11:37:26,
	Serialize complete at 15/02/2005 11:37:26
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Network card is the intel e1000 ethernet card. I tried with rxpolling
> turned on and off. Bug doesnot appear in loopback.
Compiling with the linux 2.6.10rc1 e1000 driver does not change anything. That 
may not come from the driver.

Vincent ROQUETA
